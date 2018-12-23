package com.pwk.service;

import com.pwk.entity.Case;

import java.util.List;

/**
 * Created by wenkai.peng on 10/23/2014.
 */
public interface CaseService {
    public void add(Case cases);
    public void delete(int id);
    public void update(Case cases);
    public Case getById(int id);
    public List<Case> getByList(int page, int size);
    public List<Case> getAll();
    public int getTotal();
}
