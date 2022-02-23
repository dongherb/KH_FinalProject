package ms.com.service;

import java.io.File;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import ms.com.dao.AdvertisementDAO;
import ms.com.dto.AdvertisementDTO;

@Service
public class AdvertisementService {
	@Autowired
	private AdvertisementDAO dao;

	public int insertAd(AdvertisementDTO dto, String realPath, MultipartFile file) throws Exception {
		File realPathFile = new File(realPath);
		if (!realPathFile.exists()) {
			realPathFile.mkdir();
		}

		if (!file.isEmpty()) {
			String ori_name = file.getOriginalFilename();
			String sys_name = UUID.randomUUID() + "_" + ori_name;
			System.out.println(sys_name);

			file.transferTo(new File(realPath + File.separator + sys_name));
			dto.setProduct_img(sys_name);
		}
		return dao.insertAd(dto);
	}
	
	public int deleteAd(String weather) throws Exception{
		return dao.deleteAd(weather);
	}
	
	// 메인 페이지에서 띄울 광고 가져오기 (날씨별)
	public List<AdvertisementDTO> selectListByForecast(String weather) throws Exception {
		return dao.selectListByForecast(weather);
	}
	
	
}
