package ms.com.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ms.com.dto.AdvertisementDTO;

@Repository
public class AdvertisementDAO {
	@Autowired
	private SqlSession session;
	
	public int insertAd(AdvertisementDTO dto) throws Exception{
		return session.insert("advertisementMapper.insertAd", dto);
	}
	
	public int deleteAd(String weather) throws Exception{
		return session.delete("advertisementMapper.deleteAd", weather);
	}

	// 메인 페이지에서 띄울 광고 가져오기
	public List<AdvertisementDTO> selectListByForecast(String weather) {
		return session.selectList("advertisementMapper.selectListByForecast", weather);
	}
}
