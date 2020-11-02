
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <style>
            ul,li{
                margin: 0;
                padding: 0;
                list-style: none;
            }
            .filterBox input{
                width: 100px;
            }
            .filterBox li{
                float: left;
                margin-right: 8px;
                margin-bottom: 8px;
            }
            .filterBox{
                margin-left: 10%;
            }
            .pageBox{
                position: absolute;
                right: 10%;
            }
            .pageBox li{
                float: left;
                margin-left: 8px;
                margin-top: 8px;
            }
        </style>

        <script>
            window.onload = function () {
                //ajax发送请求，加载表格数据
                loadData();

                //点击查询按钮时，需要加载数据
                let queryBtn = document.getElementById('queryBtn');
                queryBtn.onclick = function () {
                    loadData();
                }
                //点击清空查询按钮时，需要加载数据
                let clearBtn = document.getElementById('clearBtn');
                clearBtn.onclick = function () {
                    document.getElementById('rno').value = '';
                    document.getElementById('rname').value = '';
                    document.getElementById('description').value = '';
                    loadData();
                }
                //点击上一页按钮时需要加载数据
                let previousBtn = document.getElementById('previousBtn');
                previousBtn.onclick = function () {
                    let page = document.getElementById('pageSelectBtn').value;
                    if (page == 1) {
                        return;
                    }
                    page = parseInt(page);
                    page--;
                    document.getElementById('pageSelectBtn').value = page;
                    loadData();
                }

                //点击下一页按钮时需要加载数据
                let nextBtn = document.getElementById('nextBtn');
                nextBtn.onclick = function () {
                    let page = document.getElementById('pageSelectBtn').value;
                    let options = document.getElementById('pageSelectBtn').children;
                    let maxPage = options[options.length-1];
                    page = parseInt(page);
                    maxPage = parseInt(maxPage);
                    if (page == maxPage) {
                        return;
                    }
                    page++;
                    document.getElementById('pageSelectBtn').value = page;
                    loadData();
                }
                //切换页码时需要加载数据
                let pageSelectBtn = document.getElementById('pageSelectBtn');
                pageSelectBtn.onchange = function () {
                    loadData();
                }
                //切换显示条数时需要加载数据
                let rowSelectBtn = document.getElementById('rowSelectBtn');
                rowSelectBtn.onchange = function () {
                    loadData();
                }
            }

            function loadData() {
                let rno = document.getElementById('rno').value;
                let rname = document.getElementById('rname').value;
                let description = document.getElementById('description').value;
                let row = document.getElementById('rowSelectBtn').value;
                let page = document.getElementById('pageSelectBtn').value;


                //使用ajax向服务器 请求数据
                let xhr = new XMLHttpRequest() ;

                xhr.open('post', 'roleList.do', true);

                xhr.onreadystatechange = function () {
                    if (xhr.readyState == 4 && xhr.status == 200) {
                        doBack(xhr.responseText);
                    }
                }
                xhr.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
                xhr.send('rno='+rno+'&rname='+rname+'&description='+description+'&page='+page+'&row='+row+'');
            //============================================================
                function doBack(result) {
                    let pageInfo = eval('('+result+')');

                    //加载网页信息
                    //根据maxPage加载页码列表
                    let maxPage = pageInfo.maxPage;
                    let pageSelectBtn = document.getElementById('pageSelectBtn');
                    pageSelectBtn.innerHTML ='';//刷新页码
                    for(let i=1;i<=maxPage;i++){
                        pageSelectBtn.innerHTML += "<option>"+i+"</option>";
                    }
                    page = parseInt(page);
                    if (page < maxPage) {
                        pageSelectBtn.value = page;
                    }else{
                        pageSelectBtn.value = maxPage;
                    }
                    //根据list加载表格数据
                    let roleBody = document.getElementById('roleBody');
                    roleBody.innerHTML = '';//刷新表格
                    let roles = pageInfo.list;
                    if (roles.length == 0) {
                        //没有数据
                        roleBody.innerHTML = '<tr><td align="center" colspan="4">没有任何记录</td></tr>'
                    }else{
                        for (let i = 0; i < roles.length; i++) {
                            let role = roles[i];
                            let tr = document.createElement('tr');
                            tr.align='center';
                            roleBody.appendChild(tr);

                            let td1 = document.createElement('td');
                            let td2 = document.createElement('td');
                            let td3 = document.createElement('td');
                            let td4 = document.createElement('td');
                            tr.appendChild(td1);
                            tr.appendChild(td2);
                            tr.appendChild(td3);
                            tr.appendChild(td4);

                            td1.innerHTML = role.rno;
                            td2.innerHTML = role.rname;
                            td3.innerHTML = role.description;
                            td4.innerHTML = '<a href="">编辑</a> | <a href="">删除</a> | <a href="setFns.jsp?rno='+role.rno+'&rname='+role.rname+'">分配功能</a>';
                        }
                    }




                }
            }
        </script>
    </head>
    <body>
        <h3 align="center">角色列表</h3>
        <ul class="filterBox">
            <li><input id="rno" placeholder="角色编号"></li>
            <li><input id="rname" placeholder="角色名称"></li>
            <li><input id="description" placeholder="角色描述"></li>
            <li><button id="queryBtn" type="button">查询</button></li>
            <li><button id="clearBtn" type="button">清空查询</button></li>
        </ul>
        <table align="center" width="80%" border="1" cellspacing="0">
            <thead>
            <tr>
                <th>角色编号</th>
                <th>角色名称</th>
                <th>角色描述</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody id="roleBody">

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
                条
            </li>
            <li>
                跳转
                <select id="pageSelectBtn">
                    <option>1</option>
                </select>
                页
            </li>
            <li><button id="previousBtn">上一页</button></li>
            <li><button id="nextBtn">下一页</button></li>
        </ul>
    </body>
</html>
