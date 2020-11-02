<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/10/31
  Time: 9:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <script type="text/javascript" language="JavaScript" src="js/jquery.js"></script>
        <style>
            ul,li{
                list-style: none;
                margin: 0;
                padding: 0;
            }
            .box{
                width: 500px;
                margin: 50px auto;
            }
            .unLinkedBox,.linkedBox{
                width: 200px;
                height: 400px;
                border: 2px solid #ccc;
            }
            .unLinkedBox li,.linkedBox li{
                margin-bottom: 8px;
                border-bottom: 1px dotted #cccccc;
                padding-left: 5px;
                cursor: default;
            }
            li.title{
                font-weight: bold;
                border: 0;
            }
            .unLinkedBox,.btnBox,.linkedBox{
                float: left;
            }
            .btnBox{
                width: 80px;
            }
            .btnBox button{
                width: 60px;
                height: 30px;
                margin-top: 94px;
                margin-left: 10px;
            }
        </style>
        <script>
            //网页加载初始化事件函数
            $(function () {
                //ajax请求获得未分配的角色列表数据
                $.ajax({
                    url:'unLinkedRole.do',
                    type:'post',
                    data:{'uno':$('#uno').val()},
                    async:true,
                    success:function (roles) {
                        //请求成功后调用的回调函数 doBack
                        //result响应的字符串
                        //将数据显示在网页中
                        for (let i = 0; i < roles.length; i++) {
                            let role = roles[i];
                             $('.unLinkedBox').append('<li rno="'+role.rno+'">'+role.rname+'</li>');
                        }
                        addClickToRight();
                    },
                    dataType:'json'
                });

                //ajax请求获得已分配的角色列表数据
                $.ajax({
                    url:'linkedRole.do',
                    type:'post',
                    data:{'uno':$('#uno').val()},
                    async:true,
                    success:function (roles) {
                        //请求成功后调用的回调函数 doBack
                        //result响应的字符串
                        //将数据显示在网页中
                        for (let i = 0; i < roles.length; i++) {
                            let role = roles[i];
                            $('.LinkedBox').append('<li rno="'+role.rno+'">'+role.rname+'</li>');
                        }
                        addClickToLeft();
                    },
                    dataType:'json'
                });
            });

            //网页加载时初始化事件
            $(function () {
               $('#toRightBtn').click(function () {
                    $('.unLinkedBox li:gt(0)').appendTo($('.linkedBox'));
                    addClickToLeft();
               });
               $('#toLeftBtn').click(function () {
                    $('.linkedBox li:gt(0)').appendTo($('.unLinkedBox'))
                   addClickToRight();
               });
            });

            //给保存按钮增加点击事件
            $(function () {
                $('#saveBtn').click(function () {

                    //获得右侧中分配的角色编号
                    let rnos = '';
                    $('.linkedBox li:gt(0)').each(function (i,li) {
                        let rno = $(li).attr('rno');
                        rnos += rno+',';
                    });

                    console.log('-----'+rnos);
                    $.ajax({
                        url:"setRole.do",
                        data:{
                            'uno':$('#uno').val(),
                            'rnos':rnos
                        },
                        type:'post',
                        async:true,
                        success:function (result) {
                            alert(result);
                        }
                    });

                });
            });

            //为左侧列表选项增加向右移动的点击事件
            function addClickToRight() {
                $('.unLinkedBox li:gt(0)').off('dblclick').dblclick(function () {
                    $(this).appendTo($('.linkedBox'));

                    addClickToLeft();
                });
            }

            //为右侧列表选项增加向左移动的点击事件
            function addClickToLeft() {
                $('.linkedBox li:gt(0)').off('dblclick').dblclick(function () {
                    $(this).appendTo($('.unLinkedBox'));

                    addClickToRight();
                });
            }
        </script>
    </head>
    <body>
        <input type="hidden" id="uno" value="${param.uno}" />
        <h2 align="center">为【${param.truename}】分配角色</h2>

        <p align="center"><button id="saveBtn">保存</button></p>

        <div class="box">
            <ul class="unLinkedBox">
                <li class="title">未分配角色列表</li>

            </ul>
            <ul class="btnBox">
                <li><button id="toRightBtn"> &gt;&gt;</button></li>
                <li><button id="toLeftBtn"> &lt;&lt;</button></li>
            </ul>
            <ul class="linkedBox">
                <li class="title">已分配角色列表</li>

            </ul>
        </div>
    </body>
</html>
