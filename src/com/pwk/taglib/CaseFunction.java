package com.pwk.taglib;

import com.pwk.entity.Case;
import com.pwk.tools.Engine;

import java.util.List;

/**
 * Created by wenkai.peng on 10/23/2014.
 */
public class CaseFunction {
    public static List<Case> getByList(int page,int size){
        return Engine.caseService.getByList(page,size);
    }

    public static int getTotal(){
        return Engine.caseService.getTotal();
    }

    public static Case getById(int id){
        return Engine.caseService.getById(id);
    }

    public static List<Case> getAll(){
        return Engine.caseService.getAll();
    }
}
