package ms.com.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import ms.com.dto.AdvertisementDTO;
import ms.com.service.AdvertisementService;
import ms.com.service.ProductService;

@Controller
@RequestMapping("/advertisement")
public class AdvertisementController {
	@Autowired
	private AdvertisementService service;
	@Autowired
	private ProductService product_service;
	@Autowired
	private HttpSession session;
	
	@RequestMapping("/toInsertAd")
	public String toInsertAd() throws Exception{
		return "advertisement_manager/insertAdvertisement";
	}
	
	@RequestMapping("/insertAd.do")
	public String insertAd(String weather, String product_code1, MultipartFile file1, String product_code2, MultipartFile file2
			, String product_code3, MultipartFile file3, String product_code4, MultipartFile file4) throws Exception{
		String realPath = session.getServletContext().getRealPath("product_img");
		String[] product_code = {product_code1, product_code2, product_code3, product_code4};
		MultipartFile[] file = {file1, file2, file3, file4};
		
		service.deleteAd(weather);	// 기존에 있던 광고 삭제
		
		AdvertisementDTO dto = new AdvertisementDTO();
		for(int i = 0; i < product_code.length; i++) {
			dto.setWeather(weather);
			dto.setProduct_code(product_code[i]);
			service.insertAd(dto, realPath, file[i]);
		}
		
		return "redirect:/toManagerPage";
	}
	
	
	@RequestMapping("/toDeleteAd")
	public String toDeleteAd() throws Exception{
		return "advertisement_manager/deleteAdvertisement";
	}
	
	@RequestMapping("/deleteAd.do")
	public String deleteAd(String weather) throws Exception{
		service.deleteAd(weather);
		return "redirect:/toManagerPage";
	}
	
	@RequestMapping("/toPopup")
	public String toPopup(String product_code, Model model) throws Exception{
		model.addAttribute("dto", product_service.selectOne_product(product_code));
		return "advertisement_manager/checkCodePopup";
	}
	
}
