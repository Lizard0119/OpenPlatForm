<%@ page contentType="text/html;charset=UTF-8" language="java" %><html>
<head>
    <meta content="text/html" charset="utf-8" language="java">
    <title>Layui</title>
    <%--<meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">--%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
    <script src="${pageContext.request.contextPath}/layui/layui.js"></script>
    <!--注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的-->
    <style>
        .client-input {
            width: 80%;
        }

        #save-client {
            margin-top: 15px;
        }
    </style>
</head>
<body>

<form id="save-client" class="layui-form" lay-filter="example">

    <div class="layui-form-item">
        <label class="layui-form-label">用户名</label>
        <div class="layui-input-block">
            <input name="username" class="layui-input client-input" type="text" placeholder="请输入用户名" autocomplete="off"
                   lay-verify="title" lay-reqText="用户名不能为空">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">密码</label>
        <div class="layui-input-block">
            <input name="password" class="layui-input client-input" type="password " placeholder="请输入密码" autocomplete="off"
                   lay-verify="password" lay-reqText="密码不能为空">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">公司名称</label>
        <div class="layui-input-block">
            <input name="nickname" class="layui-input client-input" type="text" placeholder="请输入公司名称" autocomplete="off"
                   lay-verify="required" lay-reqText="公司名称不能为空">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">账户金额</label>
        <div class="layui-input-block">
            <input name="money" class="layui-input client-input" type="number" placeholder="请输入账户金额" autocomplete="off"
                   lay-verify="money">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">公司地址</label>
        <div class="layui-input-block">
            <input name="address" class="layui-input client-input" type="text" placeholder="请输入公司地址" autocomplete="off"
                   lay-verify="required" lay-reqText="公司地址不能为空">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">状态</label>
        <div class="layui-input-block">
            <input name="state" title="正常" type="radio" checked="" value="1">
            <input name="state" title="停用" type="radio" value="0">
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button id="save-btn" class="layui-btn" type="submit" lay-filter="demo1" lay-submit="">立即提交</button>
            <button class="layui-btn layui-btn-primary" type="reset">重置</button>
        </div>
    </div>
</form>

<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>
    layui.use(['form', 'jquery', 'layer','layedit','laydate'], function () {
        var form = layui.form
            , $ = layui.jquery
            , layedit = layui.layedit

        var editIndex = layedit.build('LAY_demo_editor');


        //自定义验证规则
        form.verify({
            title: function (value) {
                if (value.length < 5) {
                    return '用户名至少得5个字符';
                }
            }
            ,money: function (value) {
                if (value < 0)
                    return '账户金额只能为正数。';
            }
            ,content:function (value) {
                layedit.sync(editIndex);
            }
            ,password:
                [/^[\S]{6,12}$/,
                '密码必须为6-12位，且不能出现空格']
        });

        form.on('submit(demo1)', function (data) {
            console.log(data.field);

            $.post("/insertUser", {
                // id:data.field.id,
                username:data.field.username,
                password:data.field.password,
                nickname:data.field.nickname,
                money:data.field.money,
                address:data.field.address,
                state:data.field.state
            }, function (res) {
                if (res == "success") {
                    var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                    setTimeout(function () { parent.layer.close(index) }, 100);//延迟
                }
            });
            return false;
        });
    });
</script>

</body>
</html>