<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <style>
            #menuBox{
                width: 1000px;
                margin-top: 30px;
            }
            #menuBox li{
                list-style: none;
                margin-top: 4px;
                cursor: default;
            }
            #menuBox div{

                border-bottom: 1px solid #cccccc;
            }
            #menuBox span{
                display: block;
                width: 200px;
                height: 16px;
                float: right;
            }
            #menuBox input{
                width: 100px;
            }
            #menuBox div#active{
                background: #008c8c;
            }
        </style>
        <script src="js/jquery.js"></script>
        <script>
            window.onload = function () {
                loadData();
            }

            function loadData() {
                //ajax查询所有的功能信息
                let xhr = new XMLHttpRequest();

                xhr.open('post', 'fnList.do', true);

                xhr.onreadystatechange = function () {
                    if (xhr.readyState == 4 && xhr.status == 200) {
                        doBack(xhr.responseText);
                    }
                }
                xhr.send();

                function doBack(result) {
                    //显示功能列表
                    let fnList = eval('(' + result + ')');
                    let menuBox = document.getElementById('menuBox');
                    showFn(fnList,menuBox);//将第一层（根菜单）显示在指定的div中

                    //将某一层fns菜单 显示在指定的position位置
                    function showFn(fns,position) {
                        let ul = document.createElement("ul");
                        position.appendChild(ul);
                        for (let i = 0; i < fns.length; i++) {
                            let fn = fns[i];
                            let li = document.createElement("li");
                            ul.appendChild(li);

                            let div = document.createElement("div");
                            li.appendChild(div);
                            let flag = fn.flag == 1 ? '<font color="blue">菜单</font>' : '<font color="red">按钮</font>';
                            div.fno = fn.fno;
                            div.fname = fn.fname;
                            div.fhref = fn.fhref;
                            div.ftarget = fn.ftarget;
                            div.flag = fn.flag;
                            div.pno = fn.pno;
                            div.innerHTML = fn.fname+'<span>'+fn.ftarget+'</span><span>'+fn.fhref+'</span><span>'+flag+'</span>';
                            if (fn.children && fn.children.length > 0) {
                                //有子内容
                                showFn(fn.children, li);
                            }
                        }
                    }

                    let divs = menuBox.getElementsByTagName("div");
                    for (let i = 0; i < divs.length; i++) {
                        let d = divs[i];
                        d.ondblclick = function () {
                            let nextUl = this.nextElementSibling;
                            if(nextUl){
                                //有相邻的ul标签  有子菜单 展开或者合并
                                if (nextUl.style.display == 'none') {
                                    nextUl.style.display = 'block'
                                }else{
                                    nextUl.style.display = 'none';
                                }
                            }
                        }
                    }

                    //======================================
                    //点击网页空白处，右键开启新建主功能
                    document.oncontextmenu = function () {
                        return addRootFn();
                    }

                    //点击新建主功能按钮时，开启新建主功能
                    let addRootFnBtn = document.getElementById('addRootFnBtn');
                    addRootFnBtn.onclick = function () {
                        addRootFn();

                    }

                    //==========================================
                    //每一个菜单项增加一个右键新建子功能操作
                    let menuBox1 = document.getElementById('menuBox');
                    let divs1 = document.getElementsByTagName('div');
                    for (let i = 0; i < divs.length; i++) {
                        let div = divs[i];
                        div.oncontextmenu = function (ev) {
                            return addChildFn(this,ev);
                        }
                    }

                    //============================================
                    //为每一个菜单增加单击选中效果
                    let menuBox2 = document.getElementById('menuBox');
                    let divs2 = menuBox2.getElementsByTagName('div');
                    for (let i = 0; i < divs.length; i++) {
                        let div = divs2[i];
                        div.onclick = function () {
                            let active = document.getElementById('active');
                            if (active) {
                                active.id = '';
                            }
                            this.id = 'active';
                        }
                    }

                    //====================================
                    //为删除按钮增加点击事件
                    let deleteBtn = document.getElementById('deleteBtn');
                    deleteBtn.onclick = function () {
                        //div
                        let active = document.getElementById('active');
                        if (!active) {
                            alert('请选择要删除的记录');
                            return;
                        }
                        let ul = active.nextElementSibling;
                        if (ul && ul.children.length>0) {
                            alert('请先删除子功能');
                            return;
                        }
                        if (confirm('是否确认删除')) {
                            //ajax请求删除记录
                            let xhr = new XMLHttpRequest();

                            xhr.open('get', 'fnDelete.do?fno='+active.fno, true);

                            xhr.onreadystatechange = function () {
                                if (xhr.readyState == 4 && xhr.status == 200) {
                                    doBack(xhr.responseText);
                                }
                            };

                            xhr.send();

                            function doBack(result) {
                                alert('删除成功!');
                                let menuBox = document.getElementById('menuBox');
                                let uls = menuBox.children;
                                let ul = uls[uls.length - 1];
                                menuBox.removeChild(ul);
                                loadData();
                            }

                        }
                    }

                    //=====================================
                    //为编辑按钮增加点击事件
                    let editBtn = document.getElementById('editBtn');
                    editBtn.onclick = function () {
                        let fname = document.getElementById('fname');
                        if (fname) {
                            alert('还有未完成的操作');
                            return false;
                        }

                        let active = document.getElementById('active');
                        if (!active) {
                            alert('请选择要编辑的记录');
                            return;
                        }


                        let oldHtml = active.innerHTML; //装载编辑之前显示的文本内容
                        active.innerHTML = '<input id="fname" placeholder="功能名称" value="'+active.fname+'"/>'+
                            '<span><input id="ftarget" placeholder="显示位置" value="'+active.ftarget+'" /><button id="saveBtn" style="margin-left: 3px">保存</button><button id="cancelBtn" style="margin-left: 3px">取消</button></span>'+
                            '<span><input id="fhref" placeholder="功能请求" value="'+active.fhref+'"/></span>';
                        if (active.flag == 1){
                            active.innerHTML += '<span><select id="flag"><option value="1" selected="selected">菜单</option><option value="2">按钮</option></select></span>';
                        }else {
                            active.innerHTML += '<span><select id="flag"><option value="1" >菜单</option><option value="2" selected="selected">按钮</option></select></span>';
                        }
                        let cancelBtn = document.getElementById('cancelBtn');
                        cancelBtn.onclick = function () {
                            active.innerHTML = oldHtml;
                        }

                        let saveBtn = document.getElementById('saveBtn');
                        saveBtn.onclick = function () {
                            let fname = document.getElementById('fname').value;
                            let ftarget = document.getElementById('ftarget').value;
                            let fhref = document.getElementById('fhref').value;
                            let flag = document.getElementById('flag').value;
                            let fno = active.fno;

                            //ajax发送保存功能的请求
                            let xhr = new XMLHttpRequest();

                            xhr.open('post', 'fnUpdate.do', true);

                            xhr.onreadystatechange = function () {
                                if (xhr.readyState == 4 && xhr.status == 200) {
                                    doBack(xhr.responseText);
                                }
                            }

                            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

                            xhr.send('fname='+fname+'&ftarget='+ftarget+'&fhref='+fhref+'&flag='+flag+'&fno='+fno+'');

                            function doBack(result) {
                                alert('修改成功');
                                let menuBox = document.getElementById('menuBox');
                                let uls = menuBox.children;
                                let ul = uls[uls.length - 1];
                                menuBox.removeChild(ul);
                                loadData();
                            }

                        }

                    }
                }

            }

            function addChildFn(parent,ev) {
                ev.cancelBubble = true; //阻止冒泡
                let spans = parent.getElementsByTagName('span');
                let last_span = spans[spans.length - 1];
                if(last_span.innerHTML.indexOf("按钮") != -1){
                    //当前右键的功能是一个按钮，不能增加子功能
                    alert('不能为按钮增加子功能');
                    return false;
                }

                let ul = parent.nextElementSibling;    //相邻的ul，装载着子菜单信息
                if(!ul){
                    ul = document.createElement('ul');
                    parent.parentNode.appendChild(ul);
                }
                //----------------------------
                return addFn(ul, parent.fno);
            }

            function addRootFn() {
                let menuBox = document.getElementById('menuBox');
                let uls = menuBox.children;
                let ul = uls[uls.length - 1];
                return addFn(ul, -1);

            }

            function addFn(ul,pno) {

                let fname = document.getElementById('fname');
                if (fname) {
                    alert('还有未完成的操作');
                    return false;
                }
                //----------
                let li = document.createElement("li");
                ul.appendChild(li);

                let div = document.createElement('div');
                li.appendChild(div);

                div.innerHTML = '<input id="fname" placeholder="功能名称" />'+
                    '<span><input id="ftarget" placeholder="显示位置" /><button id="saveBtn" style="margin-left: 3px">保存</button><button id="cancelBtn" style="margin-left: 3px">取消</button></span>'+
                    '<span><input id="fhref" placeholder="功能请求" /></span>'+
                    '<span><select id="flag"><option value="1">菜单</option><option value="2">按钮</option></select></span>';

                //为保存和取消两个按钮增加点击事件
                let cancelBtn = document.getElementById('cancelBtn');
                cancelBtn.onclick = function () {
                    ul.removeChild(li);
                }

                let saveBtn = document.getElementById('saveBtn');
                saveBtn.onclick = function () {
                    let fname = document.getElementById('fname').value;
                    let ftarget = document.getElementById('ftarget').value;
                    let fhref = document.getElementById('fhref').value;
                    let flag = document.getElementById('flag').value;
                    //let pno = -1;

                    //ajax发送保存功能的请求
                    let xhr = new XMLHttpRequest();

                    xhr.open('post', 'fnAdd.do', true);

                    xhr.onreadystatechange = function () {
                        if (xhr.readyState == 4 && xhr.status == 200) {
                            doBack(xhr.responseText);
                        }
                    }

                    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

                    xhr.send('fname='+fname+'&ftarget='+ftarget+'&fhref='+fhref+'&flag='+flag+'&pno='+pno+'');

                    function doBack(result) {
                        alert('保存成功');
                        let menuBox = document.getElementById('menuBox');
                        let uls = menuBox.children;
                        let ul = uls[uls.length - 1];
                        menuBox.removeChild(ul);
                        loadData();
                    }
                }

                return false;
            }

            $(function () {
                //ajax 请求登录用户功能按钮 权限控制
                $.get('userButtons.do',{},function (buttons) {
                    $('[url]').hide(0);
                    for (let i = 0; i < buttons.length; i++) {
                        let button = buttons[i];
                        $('[url="'+button.fhref+'"]').show(0);
                    }
                },'json');

            })

        </script>
    </head>
    <body>
        <div id="menuBox">
            <ul>
                <li>
                    <button id="addRootFnBtn">新建主功能</button>
                    <button id="addFnBtn">新建子功能</button>
                    <button url="menuDelete.do " id="deleteBtn">删除功能</button>
                    <button id="editBtn">编辑功能</button>
                </li>
                <li style="border:0;font-weight: bold">
                    <div style="font-size: 24px">
                        菜单名称
                        <span>显示位置</span>
                        <span>功能请求</span>
                        <span>功能类型</span>
                    </div>
                </li>
            </ul>
        </div>
    </body>
</html>
