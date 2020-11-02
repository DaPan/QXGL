<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>登录</title>
    <style type="text/css">
      body{
        background-color: rgb(255,139,138);
      }
      .content{
        float: left;
        margin: 150px auto;
        font-weight: bold;
        font-size: 36px;
      }
      .loginBox{
        width: 400px;
        background-color: lightpink;
        padding: 10px 0;
        margin: 100px;

        border: 2px solid #cccccc;
        border-radius: 20px;
        float: right;
      }
      .loginBox tr{
        height: 45px;
      }
      .loginBox input{
        height: 30px;
        width: 250px;
        padding-left: 5px;
      }
      .loginBox button{
        width: 100px;
        height: 30px;
        margin-top: 20px;
      }
      #msg{
        color: red;
        font-size: 14px;
        height: 10px;
      }
    </style>
  </head>
  <body>
    <div class="content">
      <h2>欢迎登录大潘人员信息管理系统</h2>
    </div>
    <div class="loginBox">
      <form action="login.do" method="post">
        <h3 align="center">用户登录</h3>
        <table align="center">
          <tr id="msg">
            <td colspan="2" >${param.flag==9?"用户名或密码错误":""}</td>
          </tr>
          <tr>
            <td>用户名：</td>
            <td><input type="text" value="" name="uname" required="required"></td>
          </tr>
          <tr>
            <td>密码：</td>
            <td><input type="password" value="" name="upass" required="required"></td>
          </tr>
          <tr>
            <td colspan="2" align="center">
              <button type="submit">登录</button>
            </td>
          </tr>
        </table>
      </form>
    </div>
  </body>
</html>
