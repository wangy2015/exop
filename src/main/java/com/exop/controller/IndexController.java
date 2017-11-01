package com.exop.controller;

import com.exop.model.Org;
import com.exop.model.Record;
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
import java.util.*;

/**
 * Created by hanxioana on 2017/10/24.
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
    public Record upload(@RequestParam(value = "file", required = true) MultipartFile file,
                                      @RequestParam(value = "orgId", required = true) String orgId,
                                      @RequestParam(value = "fileMonth", required = true) String fileMonth,
                                      HttpServletRequest request) throws IOException {
        String path = this.indexService.uploadFile(file);
        Record record = new Record();
        record.setOrgId(orgId);
        record.setFileMonth(fileMonth);
        record.setFilePath(path);
        record.setEntryTime(new Date());
        this.indexService.insertRecord(record);
        return record;
    }

    @RequestMapping(value = "/findRecords",method= RequestMethod.POST)
    @ResponseBody
    public List<Record> findRecords(@RequestParam(value = "orgId", required = false) String orgId,
                         @RequestParam(value = "fileMonth", required = false) String fileMonth,
                         HttpServletRequest request) throws IOException {
        return this.indexService.findRecords(orgId, fileMonth);
    }

    @RequestMapping(value="/getOrgList",method= RequestMethod.GET)
    @ResponseBody
    public List<Org> getOrgList() {
        return this.indexService.getOrgList();
    }
}
