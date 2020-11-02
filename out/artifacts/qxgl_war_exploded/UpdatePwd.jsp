
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
      <style>
          .updatePwdBox{
              width: 300px;
              background: #cfc;
              border: 2px solid #ccc;
              border-radius: 10px;
              padding: 10px;
              margin: 50px auto;
          }
          .updatePwdBox li{
              list-style: none;
              margin-bottom: 8px;
          }
          .updatePwdBox input{
              width: 240px;
              height: 30px;
          }
          .updatePwdBox button{
              width: 75px;
          }
      </style>
        <script>
            window.onload = function () {
                let updatePwdForm = document.getElementById('updatePwdForm');
                updatePwdForm.onsubmit = function () {
                    let newpass = document.getElementById('newpass');
                    let repeatpass = document.getElementById('repeatpass');
                    if(newpass.value == repeatpass.value)
                        return true;
                    alert('两次密码不一致');
                    return false;
                }
            }
        </script>
    </head>
    <body>
        <div class="updatePwdBox">
            <h3 align="center">修改密码</h3>
            <form id="updatePwdForm" action="updatePwd.do" method="post">
                <ul>
                    <li><input name="oldPass" id="oldpass" type="password" placeholder="原密码" required="required"></li>
                    <li><input name="newPass" id="newpass" type="password" placeholder="新密码" required="required"></li>
                    <li><input id="repeatpass" type="password" placeholder="确认密码" required="required"></li>
                    <li><button type="submit">保存</button></li>
                </ul>
            </form>

        </div>
    </body>
</html>
