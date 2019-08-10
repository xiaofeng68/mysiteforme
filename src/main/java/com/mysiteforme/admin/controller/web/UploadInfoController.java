package com.mysiteforme.admin.controller.web;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mysiteforme.admin.base.BaseController;
import com.mysiteforme.admin.entity.UploadInfo;
import com.mysiteforme.admin.util.RestResponse;
import com.xiaoleilu.hutool.log.Log;
import com.xiaoleilu.hutool.log.LogFactory;

/**
 * Created by wangl on 2018/1/21.
 * todo:
 */
@RequestMapping("info")
@Controller
public class UploadInfoController extends BaseController{

    private static Log log = LogFactory.get();

    

    /**
     * 附件提交
     * @param infoComment
     * @param request
     * @return
     */
    @PostMapping("saveComment")
    @ResponseBody
    public RestResponse add(UploadInfo uploadInfo, HttpServletRequest request){
        if(uploadInfoService.insertOrUpdate(uploadInfo)) {
            log.info("附件{}上传成功", uploadInfo.getName());
            return RestResponse.success();
        }else {
            log.info("附件{}上传失败", uploadInfo.getName());
            return RestResponse.failure("上传附件失败");
        }
    }

    
}
