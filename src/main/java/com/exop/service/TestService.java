package com.exop.service;

import com.exop.dao.TestMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by hanxioana on 2017/10/23.
 */
@Service("testService")
public class TestService {
    @Resource
    private TestMapper testMapper;
    public long countTest() {
        return this.testMapper.countTest();
    }
}
