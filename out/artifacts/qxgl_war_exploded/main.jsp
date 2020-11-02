
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>主页</title>
    <style type="text/css">
        html,body{
            width: 100%;
            height: 100%;
            margin: 0;
            padding: 0;
        }
        .top{
            height: 20%;
            width: 100%;
            background-color: rgb(255,139,138);
            position: relative;
        }
        h2{
            margin: 0;
            position: relative;
            font-size: 28px;
            top:40%;
            left: 5%;
        }
        .top div{
            position: absolute;
            bottom: 15%;
            right: 5%;
        }
       .top span{
           color: #008c8c;
       }
        .left{
            height: 80%;
            width: 20%;
            background-color: #ccc;
            float: left;
        }
        ul,li{
            margin: 0;
            padding: 0;
            list-style: none;
        }
        li{
            margin-left: 20px;
            margin-top: 7px;
        }
        .menu div{
            cursor: default;
        }
        .right{
            height: 80%;
            width: 80%;
            background-color: #eee;
            float: right;
        }
    </style>
    <script src="js/jquery.js"></script>
    <script>
        function toExit() {
           let f =  confirm("是否确认退出？");
           if(f == false)
               return;
            location.href = 'exit.do';
        }

        $(function () {
            //ajax请求当前用户的权限功能，展示菜单
            $.post('userMenus.do',{},function (fns) {
                showMenus(fns,$('.menu'));

                function showMenus(fnList,$position) {
                    let ul = $('<ul>');
                    $position.append(ul);
                    for(let i=0;i<fnList.length;i++){
                        let fn = fnList[i];
                        let li = $('<li>');
                        ul.append(li);
                        let div = $('<div>');
                        li.append(div);

                        if(fn.fhref){
                            //需要发请求
                            div.append('<a href="'+fn.fhref+'" target="'+fn.ftarget+'">'+fn.fname+'</a>');
                        }else{
                            div.append(fn.fname);
                        }
                        if (fn.children) {
                            showMenus(fn.children, li);
                        }
                    }
                }
                $('#menuBox div').click(function () {
                    $(this).next('ul').slideToggle(600);
                });

            },'json');
        });


    </script>
</head>
<body>
    <div class="top">
        <h2>大潘人员信息管理系统</h2>
        <div>
            欢迎【<a href="javascript:toExit()"><span>${sessionScope.loginUser.truename}</span></a>】登录
        </div>
    </div>
    <div class="left menu">









        <!--
        <ul>
            <li>
                <div>权限管理</div>
                <ul>
                    <li>
                        <div><a href="userList.do" target="right">用户管理</a></div>
                    </li>
                    <li><div><a href="roleList.jsp" target="right">角色管理</a></div></li>
                    <li><div><a href="FnList.jsp" target="right">功能管理</a></div></li>
                </ul>
            </li>
            <li><div>基本信息管理</div></li>
            <li><div>经营管理</div></li>
            <li><div>库存管理</div></li>
            <li><div>财务管理</div></li>
            <li>
                <div>系统管理</div>
                <ul>
                    <li><div><a href="UpdatePwd.jsp" target="right">修改密码</a></div></li>
                </ul>
            </li>
        </ul>
        -->
    </div>
    <div class="right">
        <iframe name="right" width="100%" height="100%" frameborder="0"></iframe>
    </div>
</body>
</html>
