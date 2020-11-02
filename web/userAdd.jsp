
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <style>
            .userAddBox{
                width: 400px;
                padding: 10px;

                background: #cfc;
                border: 2px solid #ccc;
                border-radius: 10px;
                margin: 50px auto;
            }
            .userAddBox input.txt{
                height: 30px;
                width: 200px;
            }
            .userAddBox tr{
                height: 40px;
            }
            .userAddBox button{
                width: 80px;
                height: 30px;
            }
        </style>
    </head>
    <body>
        <div class="userAddBox">
            <h3 align="center">用户新增</h3>
            <form action="userAdd.do" method="post">
                <table align="center">
                    <tr>
                        <td>用户名：</td>
                        <td><input class="txt" name="uname" required="required"></td>
                    </tr>
                    <tr>
                        <td>密码：</td>
                        <td><input class="txt" name="upass" value="123" readonly="readonly" required="required"></td>
                    </tr>
                    <tr>
                        <td>真实姓名：</td>
                        <td><input class="txt" name="truename" required="required"></td>
                    </tr>
                    <tr>
                        <td>年龄：</td>
                        <td><input class="txt" name="age" type="number" required="required"></td>
                    </tr>
                    <tr >
                        <td>性别：</td>
                        <td>
                            <label><input type="radio" name="sex" value="男" checked="checked">男</label>
                            <label><input type="radio" name="sex" value="女">女</label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <button type="submit">保存</button>
                        </td>
                    </tr>
                </table>
            </form>

        </div>
    </body>
</html>
