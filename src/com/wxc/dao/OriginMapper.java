package com.wxc.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.wxc.entity.Licence;
import com.wxc.entity.Origin;
import com.wxc.entity.VideoToken;

public interface OriginMapper {
	int deleteByPrimaryKey(Integer id);

    int insert(Origin record);

    int insertSelective(Origin record);

    Origin selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Origin record);

    int updateByPrimaryKey(Origin record);

	List<Origin> getAllOrigins(int page, Integer limit, String channel);

	int queryCount(String channel);

	int getNoCount(int userId);

	List<Origin> getNoBlockOrigins(int page, Integer limit, int userId);

	List<Origin> getBlockOrigins(int page, Integer limit, int userId);

	int getYesCount(int userId);

	Origin queryByTxIdOrHash(String searchContent);

	List<Origin> getNoSave(String channel);

	List<Origin> getShowCalligraphyBlockOrigins(@Param("type") String type, @Param("page")Integer page,  @Param("limit")Integer limit, @Param("id") Integer id);

	void insertLicences(Licence licences);

	Licence selectlicence(@Param("originId")Integer id);

	int getShowCalligraphyBlockOriginsCount(@Param("id")Integer id, @Param("type")String type);

	int addVideoToken(VideoToken videoToken);

	VideoToken selectVideoTokenByUserId(VideoToken videoToken);

	int updateVideoTokenById(VideoToken v);
}