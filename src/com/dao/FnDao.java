package com.dao;

import com.domain.Fn;
import jdbc.annotations.Delete;
import jdbc.annotations.Insert;
import jdbc.annotations.Select;
import jdbc.annotations.Update;

import java.util.List;
import java.util.Map;

public interface FnDao {

    @Select("select fno,fname,ifnull(fhref,'')fhref,ifnull(ftarget,'')ftarget,flag,pno,yl1,yl2 from t_fn where del = 1")
    public List<Fn> findFnAll();

    @Insert("insert into t_fn values(null,#{fname},#{fhref},#{ftarget},#{flag},#{pno},1,now(),#{yl1},#{yl2})")
    public void saveFn(Fn fn);

    @Update("update t_fn set del = 2 where fno = #{fno}")
    public void deleteFn(Integer fno);

    @Update("update t_fn set fname=#{fname},fhref=#{fhref},flag = #{flag},ftarget=#{ftarget} where fno = #{fno}")
    public void updateFn(Fn fn);

    @Delete("delete from t_role_fn where rno = #{rno}")
    public void removeRelationshipByRole(Integer rno);

    @Insert("insert into t_role_fn values(#{rno},#{fno})")
    public void addRelationshipForRole(Map<String,Object> param);

    @Select("select fno from t_role_fn where rno = #{rno}")
    public List<Integer> findLinkedFns(Integer rno);

    @Select("select * from t_fn where flag = 1 and fno in(select fno from t_role_fn where rno in(select rno from t_user_role where uno =#{uno}))")
    public List<Fn> findMenuByUser(Integer uno);

    @Select("select * from t_fn where flag = 2 and fno in(select fno from t_role_fn where rno in(select rno from t_user_role where uno =#{uno}))")
    public List<Fn> findButtonByUser(Integer uno);

    @Select("select * from t_fn where fno in(select fno from t_role_fn where rno in(select rno from t_user_role where uno =#{uno}))")
    public List<Fn> findFnsByUser(Integer uno);

}
