<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <style>
            .userEditBox{
                width: 400px;
                padding: 10px;

                background: #cfc;
                border: 2px solid #ccc;
                border-radius: 10px;
                margin: 50px auto;
            }
            .userEditBox input.txt{
                height: 30px;
                width: 200px;
            }
            .userEditBox tr{
                height: 40px;
            }
            .userEditBox button{
                width: 80px;
                height: 30px;
            }
        </style>
    </head>
    <body>
        <div class="userEditBox">
            <h3 align="center">用户编辑</h3>
            <form action="userUpdate.do" method="post">
                <input name="uno" type="hidden" value="${requestScope.user.uno}">
                <table align="center">
                    <tr>
                        <td>用户名：</td>
                        <td><input class="txt" name="uname" required="required" value="${requestScope.user.uname}"></td>
                    </tr>
                    <tr>
                        <td>真实姓名：</td>
                        <td><input class="txt" name="truename" required="required" value="${requestScope.user.truename}"></td>
                    </tr>
                    <tr>
                        <td>年龄：</td>
                        <td><input class="txt" name="age" type="number" required="required" value="${requestScope.user.age}"></td>
                    </tr>
                    <tr >
                        <td>性别：</td>
                        <td>
                            <c:choose>
                                <c:when test="${requestScope.user.sex == '男'}">
                                    <label><input type="radio" name="sex" value="男" checked="checked">男</label>
                                    <label><input type="radio" name="sex" value="女">女</label>
                                </c:when>
                                <c:otherwise>
                                    <label><input type="radio" name="sex" value="男" >男</label>
                                    <label><input type="radio" name="sex" value="女" checked="checked">女</label>
                                </c:otherwise>
                            </c:choose>

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
