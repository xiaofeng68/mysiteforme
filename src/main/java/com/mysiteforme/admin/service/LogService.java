package com.mysiteforme.admin.service;

import java.util.List;

import com.baomidou.mybatisplus.service.IService;
import com.mysiteforme.admin.entity.Log;

/**
 * <p>
 * 系统日志 服务类
 * </p>
 *
 * @author wangl
 * @since 2018-01-13
 */
public interface LogService extends IService<Log> {

    public List<Integer> selectSelfMonthData();

}
