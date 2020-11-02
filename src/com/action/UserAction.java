package com.action;

import com.domain.Fn;
import com.domain.PageInfo;
import com.domain.User;
import com.service.FnService;
import com.service.UserService;
import com.service.impl.FnServiceImpl;
import com.service.impl.UserServiceImpl;
import mymvc.ModelAndView;
import mymvc.RequestMapping;
import mymvc.RequestParam;
import mymvc.ResponseBody;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UserAction {

    private UserService service = UserServiceImpl.getService();
    private FnService fnService = new FnServiceImpl();

    @RequestMapping("login.do")
    public String  login(@RequestParam("uname") String uname, @RequestParam("upass") String upass, HttpServletRequest request){
        User user = service.checkLogin(uname, upass);
        if(user == null){
            //登录失败
            return "redirect:index.jsp?flag=9";
        }else {
            //登录成功
            request.getSession().setAttribute("loginUser", user);

            //查询用户的权限（功能），装入session
            List<Fn> menus = fnService.findLoginUserMenus(user.getUno());
            List<Fn> buttons = fnService.findLoginUserButtons(user.getUno());
            request.getSession().setAttribute("userMenus",menus);
            request.getSession().setAttribute("userButtons",buttons);

            List<Fn> fns = fnService.findBaseFnAll();
            request.getSession().setAttribute("fns",fns);

            List<Fn> userFns = fnService.findFnsByUser(user.getUno());
            request.getSession().setAttribute("userFns",userFns);
            return "redirect:main.jsp";

        }
    }

    @RequestMapping("userList.do")
    public ModelAndView userList(@RequestParam("uno") Integer uno,@RequestParam("uname") String uname,@RequestParam("sex") String sex,@RequestParam("page") Integer page,@RequestParam("row") Integer row){
        if(page == null){
            //没有传递page,应该是菜单访问，默认显示第一页，默认显示5条记录
            page = 1;
            row = 5;
        }
        Map<String, Object> param = new HashMap<>();
        param.put("uno", uno);
        param.put("uname", uname);
        param.put("sex", sex);
        param.put("page", page);
        param.put("row", row);

        PageInfo pageInfo = service.findUserByPageAndFilter(param);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("userList.jsp");
        mv.addAttribute("pageInfo", pageInfo);
        mv.addAttribute("uno",uno);
        mv.addAttribute("uname",uname);
        mv.addAttribute("sex",sex);
        mv.addAttribute("page",page);
        mv.addAttribute("row",row);
        return mv;
    }

    @RequestMapping("userAdd.do")
    @ResponseBody
    public String  userAdd(User user){
        service.saveUser(user);
        return "保存成功";
    }

    @RequestMapping("userDelete.do")
    public String  userDelete(@RequestParam("uno") Integer uno) {
        service.userDelete(uno);
        return "redirect:userList.do";
    }

    @RequestMapping("userEdit.do")
    public ModelAndView userEdit(@RequestParam("uno") Integer uno) {
        User user = service.findUserById(uno);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("userEdit.jsp");
        mv.addAttribute("user",user);
        return mv;
    }

    @RequestMapping("userUpdate.do")
    public String  userUpdate(User user) {
        service.userUpdate(user);
        return "redirect:userList.do";
    }

    @RequestMapping("userDeletes.do")
    public String userDeletes(@RequestParam("unoStr") String unoStr) {
        service.deleteUsers(unoStr);
        return "redirect:userList.do";
    }

    @RequestMapping("importUsers.do")
    public String importUsers(HttpServletRequest request) throws FileUploadException, IOException {
        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        List<FileItem> fis = upload.parseRequest(request);

        FileItem fi = fis.get(0);
        InputStream is = fi.getInputStream();

        List<User> users = new ArrayList<>();//装载excel文件里的内容
        Workbook book = WorkbookFactory.create(is);
        Sheet sheet = book.getSheetAt(0);
        for(int i=1;i<=sheet.getLastRowNum();i++){
            Row row = sheet.getRow(i);
            Cell c1 = row.getCell(0);
            Cell c2 = row.getCell(1);
            Cell c3 = row.getCell(2);
            Cell c4 = row.getCell(3);
            Cell c5 = row.getCell(4);

            String uname = c1.getStringCellValue();
            String upass = (int)c2.getNumericCellValue()+"";
            String truename = c3.getStringCellValue();
            Integer age = (int)c4.getNumericCellValue();
            String sex = c5.getStringCellValue();

            User user = new User(null,uname, upass, truename, sex, age,null,null);
            users.add(user);

        }
        service.importUsers(users);
        return "redirect:userList.do";
    }

    @RequestMapping("userTemplateDownload.do")
    public void userTemplateDownload(HttpServletResponse response) throws IOException {
        //读取待下载的文件
        String path = Thread.currentThread().getContextClassLoader().getResource("file/users.xls").getPath();
        System.out.println(path);
        InputStream is = new FileInputStream(path);

        OutputStream os = response.getOutputStream();

        response.setHeader("content-disposition","attachment;filename=users.xls");

        while (true) {
            int b = is.read();
            if(b == -1)
                break;
            os.write(b);
        }
    }

    @RequestMapping("exportUsers.do")
    public void exportUsers(HttpServletResponse response) throws IOException {
        //读取用户数据
        Map<String ,Object> param = new HashMap<>();
        param.put("page",1);
        param.put("row", Integer.MAX_VALUE);
        List<User> users = (List<User>) service.findUserByPageAndFilter(param).getList();

        //将数据写入excel对象--->文件
        Workbook book = new HSSFWorkbook();
        Sheet sheet = book.createSheet();

        CellStyle style = book.createCellStyle();
        style.setAlignment(HorizontalAlignment.CENTER);
        Font font = book.createFont();
        font.setBold(true);
        style.setFont(font);

        {
            Row row = sheet.createRow(0);
            Cell c1 = row.createCell(0);
            Cell c2 = row.createCell(1);
            Cell c3 = row.createCell(2);
            Cell c4 = row.createCell(3);
            Cell c5 = row.createCell(4);
            c1.setCellValue("用户编号");
            c2.setCellValue("用户名称");
            c3.setCellValue("真实姓名");
            c4.setCellValue("用户性别");
            c5.setCellValue("用户年龄");
            c1.setCellStyle(style);
            c2.setCellStyle(style);
            c3.setCellStyle(style);
            c4.setCellStyle(style);
            c5.setCellStyle(style);
        }

        int i=1;
        for (User user : users) {
            Row row = sheet.createRow(i++);
            Cell c1 = row.createCell(0);
            Cell c2 = row.createCell(1);
            Cell c3 = row.createCell(2);
            Cell c4 = row.createCell(3);
            Cell c5 = row.createCell(4);
            c1.setCellValue(user.getUno());
            c2.setCellValue(user.getUname());
            c3.setCellValue(user.getTruename());
            c4.setCellValue(user.getSex());
            c5.setCellValue(user.getAge());
        }
        //准备将jvm中的excel数据写入指定的盘符文件中
        String path = Thread.currentThread().getContextClassLoader().getResource("").getPath();
        File file = new File(path, "users.xls");
        OutputStream os = new FileOutputStream(file);
        book.write(os);

        //将装有用户数据的excel文件下载至浏览器
        InputStream fis = new FileInputStream(file);
        OutputStream fos = response.getOutputStream();

        response.setHeader("content-disposition","attachment;filename=users.xls");
        while (true) {
            int b = fis.read();
            if(b == -1)
                break;
            fos.write(b);
        }
    }

    @RequestMapping("exit.do")
    public String  exit(HttpServletRequest request){
        request.getSession().invalidate();
        return "redirect:index.jsp";
    }

    @RequestMapping("updatePwd.do")
    @ResponseBody
    public String  updatePwd(@RequestParam("oldPass") String oldPass,@RequestParam("newPass") String newPass,HttpServletRequest request){
        User user = (User) request.getSession().getAttribute("loginUser");
        if(!user.getUpass().equals(oldPass)){
            return "原密码不正确";
        }
        service.updatePwd(user.getUno(),newPass);
        return "密码修改成功";
    }


}
