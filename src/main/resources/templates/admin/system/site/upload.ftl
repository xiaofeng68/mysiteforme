<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>网站基本信息</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${base}/static/layui/css/layui.css" media="all" />
    <!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
    <style type="text/css">
        .layui-form-item .layui-inline{ min-width:15%; float:left; margin-right:0; }
        .layui-form-item .role-box {
            position: relative;
        }

    </style>
</head>
<body class="childrenBody">

<form class="layui-form">
    <table class="layui-table">
        <colgroup>
            <col width="20%">
            <col width="50%">
            <col>
        </colgroup>
        <thead>
        <tr>
            <th>参数说明</th>
            <th>参数值</th>
            <th>变量名</th>
        </tr>
        </thead>
        <tbody>
        
        <tr>
            <td>附件</td>
            <td>
                <input type="hidden" class="layui-input author" name="url" id="url">
                <input type="hidden" class="layui-input author" name="qrUrl" id="qrUrl">
                <input type="hidden" class="layui-input author" name="name" id="name">
                <button type="button" class="layui-btn layui-btn-normal" id="test2"><i class="layui-icon"></i>上传附件</button>
                <img <#if info.url??> src="${info.url}" <#else> src="${base}/static/images/face.jpg " </#if> class="layui-circle" id="userFace" style="width: 100px;height: 100px">
            </td>
            <td>url</td>
        </tr>
        <tr>
            <td>当前上传方式</td>
            <td>
            	<#if (site.fileUploadType == "local") >
                <input type="radio" name="fileUploadType" value="local" title="本地上传" checked="">
                </#if>
                <#if (site.fileUploadType == "qiniu") >
                <input type="radio" name="fileUploadType" value="qiniu" title="七牛云存储" lay-filter="qiniuUpload" checked="">
                </#if>
                <#if (site.fileUploadType == "oss") >
                <input type="radio" name="fileUploadType" value="oss" title="阿里云存储" lay-filter="ossUpload" checked="">
                </#if>
            </td>
            <td>在网站基本信息设置</td>
        </tr>
        
        </tbody>
    </table>
    <div class="layui-form-item" style="text-align: right;">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit="" lay-filter="info">立即提交</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
</form>
<script type="text/javascript" src="${base}/static/layui/layui.js"></script>
<script>
    layui.use(['form','layer','jquery','upload'], function(){
            var form = layui.form,
                layer = layui.layer,
                upload=layui.upload,
                $ = layui.jquery;

        //普通图片上传

        upload.render({
            elem: '#test2',
            url: '${base}/file/upload/',
            field: 'test',
            accept: 'file',
            size: 102400,//100M
            before: function (obj) {
            	this.data = {type:"qrcode"};
                //预读本地文件示例，不支持ie8
                obj.preview(function (index, file, result) {
                    $('#userFace').attr('src', result); //图片链接（base64）
                });
                layer.load(2, {
                    shade: [0.3, '#333']
                });
            },
            done: function (res) {
                layer.closeAll('loading');
                //如果上传失败
                if (res.success === false) {
                    return layer.msg('上传失败');
                }else{
                    layer.msg("上传成功",{time:1000},function () {
                        $('#qrUrl').attr('src', res.data.qrUrl);
                        $('#name').val(res.data.name);
                        $('#url').val(res.data.url);
                        $('#qrUrl').val(res.data.qrUrl);
                    })
                }
            }
        });

        form.on('radio(qiniuUpload)', function(data){
            layer.open({
                title : "七牛云信息",
                type : 2,
                content : "${base}/admin/system/site/qiniu",
                area: ['600px','550px'],
                cancel:function (index, layero) {
                    console.log(layero);
                }
            });
        });

        form.on('radio(ossUpload)', function(data){
            layer.open({
                title : "阿里云信息",
                type : 2,
                content : "${base}/admin/system/site/oss",
                area: ['600px','600px']
            });
        });

        form.on('submit(info)',function(data){
            var loadIndex = layer.load(2, {
                shade: [0.3, '#333']
            });
            $.post('${base}/info/saveComment',data.field,function (res) {
                layer.close(loadIndex);
               if(res.success){
                   layer.msg("附件上传成功",function () {
                       location.reload();
                   });

               }else{
                   layer.msg(res.message);
               }
            });
            return false;
        });
    });
</script>
</body>
</html>