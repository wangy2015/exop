package com.exop.service;

import com.exop.dao.OrgMapper;
import com.exop.dao.RecordMapper;
import com.exop.model.Org;
import com.exop.model.OrgExample;
import com.exop.model.Record;
import com.exop.model.RecordExample;
import com.sun.org.apache.regexp.internal.RE;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

/**
 * Created by 王勇 on 2017/10/24.
 */
@Service("indexService")
public class IndexService {
    @Autowired
    private HttpServletRequest request;
    @Resource
    private OrgMapper orgMapper;
    @Resource
    private RecordMapper recordMapper;

    public List<Org> getOrgList() {
        OrgExample oe = new OrgExample();
        oe.setOrderByClause("org_order");
        return orgMapper.selectByExample(oe);
    }

    public int insertRecord(Record record) {
        return this.recordMapper.insert(record);
    }

    public List<Record> findRecords(String orgId, String fileMonth) {
        RecordExample re = new RecordExample();
        RecordExample.Criteria criteria = re.createCriteria();
        if (orgId != null && !"".equals(orgId)) {
            criteria.andOrgIdEqualTo(orgId);
        }
        if (fileMonth != null && !"".equals(fileMonth)) {
            criteria.andFileMonthEqualTo(fileMonth);
        }
        return this.recordMapper.selectByExample(re);
    }

    public String uploadFile(MultipartFile file) throws IOException {
        // 取得当前上传文件的文件名称
        String fileName = file.getOriginalFilename();
        // 文件路径
        String path = "/upload-files/" + UUID.randomUUID() + "/" + fileName;
        // 文件路径
        String realPath = request.getSession().getServletContext().getRealPath(path);
        // 创建文件
        File destFile = new File(realPath);
        destFile.mkdirs();
        // 传输
        file.transferTo(destFile);
        return path;
    }
}
