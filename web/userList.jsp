
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <style type="text/css">
            ul,li{
                margin:0;
                padding: 0;
                list-style: none;
            }
            .inputBox{
                margin-left: 10%;
            }
            .inputBox li{
                float: left;
                margin-right: 8px;
                margin-bottom: 8px;
            }
            .inputBox input{
                width: 100px;
            }
            .pageBox{
                float: right;
                margin-right:10% ;
                margin-top: 10px;
            }
            .pageBox li{
                float: left;
                margin-left: 8px;
            }
            .modal{
                width: 500px;
                height: 200px;
                background: #cfc;
                border: 2px solid #ccc;
                border-radius: 20px;

                position: absolute;
                top: 100px;
                left: 50%;
                margin-left: -250px;
                box-shadow: 10px 10px 10px #ccc;
                z-index: 100;
                display: none;
            }
            .back{
                width: 100%;
                height: 100%;
                position: absolute;
                left: 0;
                top:0;
                background: #ddd;
                z-index: 99;
                opacity: 0.6;
                display: none;
            }
            .modal tr{
                height: 40px;
            }
            .modal button{
                width: 75px;
                height: 25px;
            }
        </style>
        <script type="text/javascript">
            //网页加载时执行的操作
            window.onload = function () {
                //根据查询的最大页，加载页码的列表
                let maxPage = document.getElementById('maxPage');
                let pageSelectBtn = document.getElementById('pageSelectBtn');
                for (let i = 1; i <= maxPage.value; i++) {
                    pageSelectBtn.innerHTML += '<option>'+ i +'</option>';
                }

                //根据性别，默认选中性别的选项
                let sex = document.getElementById('r_sex').value;
                document.getElementById('sex').value = sex;

                //根据转发携带页码，默认选中对应的页码
                let page = document.getElementById('r_page').value;
                let selectTag = document.getElementById('pageSelectBtn');//找到页码的下拉框
                let mPage = selectTag.children[selectTag.children.length-1].innerHTML;//找到最后一个选项的内容
                page = parseInt(page);
                mPage = parseInt(mPage);
                page = Math.min(page, mPage);
                selectTag.value = page;

                //根据转发携带记录数，默认选中对应的记录数
                let row = document.getElementById('r_row').value;
                document.getElementById('rowSelectBtn').value = row;

                //为查询按钮添加点击事件
                let queryBtn = document.getElementById('queryBtn');
                queryBtn.onclick = function () {
                    loadData();
                }

                //清空查询
                let clearBtn = document.getElementById('clearBtn');
                clearBtn.onclick = function () {
                    document.getElementById('uno').value = '';
                    document.getElementById('uname').value = '';
                    document.getElementById('sex').value = '';
                    loadData();
                }

                //上一页
                let preBtn = document.getElementById('preBtn');
                preBtn.onclick = function () {
                    let page = document.getElementById('pageSelectBtn').value;
                    if(page == 1)
                        return;
                    page = parseInt(page);
                    page--;
                    document.getElementById('pageSelectBtn').value = page;
                    loadData();
                }

                //下一页
                let nextBtn = document.getElementById('nextBtn');
                nextBtn.onclick = function () {
                    let maxPage = document.getElementById('maxPage').value;
                    let page = document.getElementById('pageSelectBtn').value;
                    maxPage = parseInt(maxPage);
                    page = parseInt(page);
                    if(page == maxPage)
                        return;
                    page++;
                    document.getElementById('pageSelectBtn').value = page;
                    loadData();
                }

                //页码切换
                let pageSelectBtn1 = document.getElementById('pageSelectBtn');
                pageSelectBtn1.onchange = function () {
                    loadData();
                }

                //每页显示记录切换
                let rowSelectBtn = document.getElementById('rowSelectBtn');
                rowSelectBtn.onchange = function () {
                    loadData();
                }
                //=====================================
                let addBtn = document.getElementById('addBtn');
                addBtn.onclick = function () {
                    location.href="userAdd.jsp";

                }
                //====================================
                let checkBtn = document.getElementById('checkBtn');
                checkBtn.onclick = function () {
                    let f = checkBtn.checked;   //获得点击状态 true/false
                    let unos = document.getElementsByClassName('checkUno');
                    for(let i=0;i<unos.length;i++){
                        let uno = unos[i];
                        uno.checked = f;
                    }
                }
                //=======================================
                    let deleteBtn = document.getElementById('deleteBtn');
                    deleteBtn.onclick = function () {
                        let unoStr = '';    //存储所有被选中的用户编号，使用逗号隔开'1,2,3'
                        let unos = document.getElementsByClassName('checkUno');
                        for(let i=0;i<unos.length;i++){
                            let uno = unos[i];
                            if(uno.checked == true){
                                unoStr += uno.value+',';
                            }
                        }
                        if(unoStr.length == 0){
                            alert("请选择要删除的记录");
                            return;
                        }
                        let f = confirm("是否确认删除");
                        if (f == false) {
                            return;
                        }
                        location.href = 'userDeletes.do?unoStr='+unoStr+'';
                }
                //==============================================
                let importBtn = document.getElementById('importBtn');
                importBtn.onclick = function () {
                    let selectFile = document.getElementById('selectFile');
                    selectFile.value = '';
                    let divs = document.getElementsByClassName('modal2');
                    for(let i=0;i<divs.length;i++){
                        let div = divs[i];
                        div.style.display = 'block';
                    }
                }
                let back = document.getElementsByClassName('back')[0];
                 back.onclick = function () {
                     let divs = document.getElementsByClassName('modal2');
                     for (let i = 0; i < divs.length; i++) {
                         let div = divs[i];
                         div.style.display = 'none';
                     }
                 }
                 //==============================================
                let templateBtn = document.getElementById('templateBtn');
                 templateBtn.onclick = function () {
                        //发送下载请求
                     location.href = 'userTemplateDownload.do';
                 }
                 //============================================
                let exportBtn = document.getElementById('exportBtn');
                exportBtn.onclick = function () {
                    location.href='exportUsers.do';
                }
            }

            //发送查询请求
            function loadData() {
                let uno = document.getElementById('uno').value;
                let uname = document.getElementById('uname').value;
                let sex = document.getElementById('sex').value;
                let page = document.getElementById('pageSelectBtn').value;
                let row = document.getElementById('rowSelectBtn').value;
                location.href = 'userList.do?uno='+uno+'&uname='+uname+'&sex='+sex+'&page='+page+'&row='+row+'';
            }

            //删除函数
            function toDelete(uno) {
                let f = confirm("是否删除?");
                if (!f) {
                    return;
                }
                location.href="userDelete.do?uno="+uno+"";
            }
        </script>
    </head>
    <body>
        <input type="hidden" id="maxPage" value="${requestScope.pageInfo.maxPage}">
        <input type="hidden" id="r_uno" value="${requestScope.uno}">
        <input type="hidden" id="r_uname" value="${requestScope.uname}">
        <input type="hidden" id="r_sex" value="${requestScope.sex}">
        <input type="hidden" id="r_row" value="${requestScope.row}">
        <input type="hidden" id="r_page" value="${requestScope.page}">
        <h2 align="center">用户列表</h2>
        <ul class="inputBox">
            <li><input id="uno" placeholder="输入编号" value="${requestScope.uno}"></li>
            <li><input id="uname" placeholder="输入名称" value="${requestScope.uname}"></li>
            <li>
                <select id="sex">
                        <option value="">=性别=</option>
                        <option>男</option>
                        <option>女</option>
                </select>
            </li>
            <li><button id="queryBtn">查询</button></li>
            <li><button id="clearBtn">清空查询</button></li>
            <c:forEach items="${userButtons}" var="fn">
                <c:if test="${fn.fhref=='userAdd.jsp'}">
                    <li><button id="addBtn">新建用户</button></li>
                </c:if>
            </c:forEach>
            <c:forEach items="${userButtons}" var="fn">
                <c:if test="${fn.fhref=='userDelete.do'}">
                    <li><button id="deleteBtn">批量删除</button></li>
                </c:if>
            </c:forEach>

            <li><button id="importBtn">批量导入</button></li>
            <li><button id="exportBtn">批量导出</button></li>
        </ul>
        <table width="80%" border="1" align="center" cellspacing="0">
            <thead>
                <tr>
                    <th><input id="checkBtn" type="checkbox"></th>
                    <th>用户编号</th>
                    <th>用户名</th>
                    <th>真实姓名</th>
                    <th>年龄</th>
                    <th>性别</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${requestScope.pageInfo.list.size() == 0}">
                        <tr align="center">
                            <td colspan="6">没有任何记录</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${requestScope.pageInfo.list}" var="user">
                            <tr align="center">
                                <td><input type="checkbox" class="checkUno" value="${user.uno}"></td>
                                <td>${user.uno}</td>
                                <td>${user.uname}</td>
                                <td>${user.truename}</td>
                                <td>${user.age}</td>
                                <td>${user.sex}</td>
                                <td>
                                    <c:forEach items="${userButtons}" var="fn">
                                        <c:if test="${fn.fhref=='userEdit.do'}">
                                            <a href="userEdit.do?uno=${user.uno}">编辑</a> |
                                        </c:if>
                                    </c:forEach>
                                    <c:forEach items="${userButtons}" var="fn">
                                        <c:if test="${fn.fhref=='userDelete.do'}">
                                            <a href="javascript:toDelete(${user.uno})">删除</a> |
                                        </c:if>
                                    </c:forEach>

                                    <a href="setRoles.jsp?uno=${user.uno}&truename=${user.truename}">分配角色</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
        <ul class="pageBox">
            <li>
                显示
                <select id="rowSelectBtn">
                    <option>5</option>
                    <option>10</option>
                    <option>15</option>
                    <option>20</option>
                </select>
                行
            </li>
            <li>
                跳转
                <select id="pageSelectBtn">

                </select>
                页
            </li>
            <li><button id="preBtn">上一页</button></li>
            <li><button id="nextBtn">下一页</button></li>
        </ul>
        <div class="modal modal2">
            <form action="importUsers.do" method="post" enctype="multipart/form-data">
                <h3 align="center">导入用户</h3>
                <table align="center">
                    <tr>
                        <td><input id="selectFile" width="75px" type="file" name="excel"> </td>
                    </tr>
                    <tr>
                        <td>
                            <button id="templateBtn" type="button">模板下载</button>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <button type="submit">保存</button>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <div class="back modal2"></div>
    </body>
</html>
