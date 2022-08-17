package com.dong.library.Service;


import com.dong.library.entity.Appoint;
import com.dong.library.mapper.AppointMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class AppointService {
    @Autowired
    public AppointMapper appointMapper;

    /**
     * 找到所有预约的书籍
     * @return
     */
    public List<Appoint> findAll() {
        List<Appoint> list = appointMapper.selectList(null);
        return list;
    }

    /**
     * 添加appoint数据
     * @param appoint
     * @return
     */
    public Boolean save(Appoint appoint) {
        int insert = appointMapper.insert(appoint);
        if(insert != -1){
            return true;
        }
        return false;
    }
}
