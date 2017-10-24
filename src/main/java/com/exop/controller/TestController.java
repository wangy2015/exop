package com.exop.controller;

import com.exop.service.TestService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * Created by 王勇 on 2017/10/23.
 */
@Controller
public class TestController {
    @Resource(name="testService")
    private TestService testService;

    @RequestMapping(value="/test",method= RequestMethod.GET)
    public ModelAndView test(HttpServletRequest request){
        System.out.println("-------------------- 进入controller--------------------");
        long result = testService.countTest();
        System.out.println(result);
        ModelAndView mv=new ModelAndView();
        mv.setViewName("test");
        return mv;
    }
}
