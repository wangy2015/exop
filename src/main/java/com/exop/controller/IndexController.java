package com.exop.controller;

import com.exop.model.Org;
import com.exop.service.IndexService;
import com.exop.service.TestService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * Created by 王勇 on 2017/10/24.
 */
@Controller
public class IndexController {
    @Resource(name="indexService")
    private IndexService indexService;

    @RequestMapping(value="/index",method= RequestMethod.GET)
    public ModelAndView index(HttpServletRequest request){
        ModelAndView mv=new ModelAndView();
        mv.setViewName("search");
        return mv;
    }

    @RequestMapping(value = "/upload",method= RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> upload(@RequestParam(value = "file", required = false) MultipartFile file, HttpServletRequest request) throws IOException {
        Map<String, Object> result = new HashMap<String, Object>();
        String path = this.indexService.uploadFile(file);
        result.put("path", path);
        return result;
    }

    @RequestMapping(value="/getOrgList",method= RequestMethod.GET)
    @ResponseBody
    public List<Org> getOrgList() {
        return this.indexService.getOrgList();
    }
}
