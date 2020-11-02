
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <script src="js/jquery.js"></script>
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

        </style>
        <script>
            $(function () {
                $.ajax({
                    url:'fnList.do',
                    data:{},
                    async:false,
                    type:'get',
                    success:function (fnList) {

                        showLevelFnList(fnList,$('#menuBox'));

                        function showLevelFnList(fns,$position) {
                            let ul = $('<ul>');
                            $position.append(ul);
                            for(let i=0;i<fns.length;i++){
                                let fn = fns[i];
                                let li = $('<li>');
                                ul.append(li);
                                let div = $('<div>');
                                li.append(div);

                                div.append('<input type="checkbox" value="'+fn.fno+'" /> ');
                                div.append(fn.fname);
                                div.append('<span>'+fn.ftarget+'</span>');
                                div.append('<span>'+fn.fhref+'</span>');
                                div.append('<span>'+(fn.flag==1?'<font color="blue">菜单</font>':'<font color="red">按钮</font>')+'</span>');

                                if (fn.children && fn.children.length > 0) {
                                    //有子菜单
                                    showLevelFnList(fn.children, li);
                                }
                            }

                        }
                        //数据装载完毕
                        //为菜单列表增加双击展开合并操作
                        $('#menuBox > ul:gt(0) div').dblclick(function () {
                            $(this).next('ul').slideToggle(600);

                        });

                        //为复选框增加点击事件
                        $('#menuBox :checkbox').click(function () {
                            if(this.checked){
                                //选中当前菜单的子级菜单
                                checkChildren($(this));

                                function checkChildren($parent) {
                                    let ul = $parent.parent().next('ul');
                                    if(ul.length>0){
                                        //有子级菜单
                                        let inputs = ul.children().children().children('input');
                                        inputs.prop('checked', true);
                                        checkChildren(inputs);
                                    }
                                }

                                //=========================
                                //选中当前菜单的父级菜单

                                checkParent($(this));

                                function checkParent($child) {
                                    let div = $child.parent().parent().parent().prev('div');
                                    if (div.length>0) {
                                        //有父级菜单
                                        let input = div.children('input');
                                        input.prop('checked', true);
                                        checkParent(input);
                                    }

                                }

                            }else{
                                //取消
                                cancelChildren($(this));
                                function cancelChildren($parent) {
                                    let ul = $parent.parent().next('ul');
                                    if (ul.length > 0) {
                                        //有子级菜单
                                        let inputs = ul.children().children().children('input');
                                        inputs.prop('checked', false);
                                        cancelChildren(inputs);
                                    }
                                }

                                //===============================
                                cancelParent($(this));

                                function cancelParent($child) {
                                    let div = $child.parent().parent().parent().prev('div');
                                    if (div.length > 0) {
                                        let input = div.children('input');
                                        let inputs = div.next().children('li').children('div').children('input:checked');
                                        console.log(inputs.length);
                                        if (inputs.length > 0) {
                                            //子菜单中还有被选中的，当前父级不被取消
                                            return;
                                        }
                                        //子菜单都被取消了，父级也需要被取消
                                        input.prop('checked', false);

                                        cancelParent(input);
                                    }

                                }
                            }
                        });

                    },
                    dataType:'json'
                });
            });

            $(function () {
                $('#saveBtn').click(function () {
                    let rno = $('#rno').val();
                    let fnos = '';
                    $('#menuBox input:checked').each(function (i,input) {
                        fnos += $(input).val()+',';
                    });

                    $.post('setFns.do',{'rno':rno,'fnos':fnos},function (result) {
                        alert(result);
                    });
                });
            });

            $(function () {
                $.post('linkedFns.do',{'rno':$('#rno').val()},function (fnos) {
                    for (let i = 0; i < fnos.length; i++) {
                        let fno = fnos[i];
                        $('input[value=' + fno + ']').prop('checked', true);
                    }
                },'json');

            })
        </script>
    </head>
    <body>
        <h2 align="center">为【${param.rname}】分配功能</h2>
        <input type="hidden" id="rno" value="${param.rno}">
        <div id="menuBox">
            <ul><li><div style="border: 0"><button id="saveBtn">保存</button> </div></li></ul>
            <ul>
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
