package ms.com.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import ms.com.dao.NoticeDAO;
import ms.com.dto.NoticeDTO;

@Service
public class NoticeService {
	@Autowired
	private NoticeDAO noticeDao;
	
	public Map<String, Object> selectOne(int notice_seq) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("dto", noticeDao.selectOne(notice_seq));
		return map;
	}

	public int insertNotice(NoticeDTO dto, String realPath, MultipartFile[] file) throws Exception {
		File realPathFile = new File(realPath);
		if (!realPathFile.exists()) {
			realPathFile.mkdir();
		}

		for (MultipartFile f : file) {
			if (!f.isEmpty()) {
				String ori_name = f.getOriginalFilename();
				String sys_name = UUID.randomUUID() + "_" + ori_name;
				System.out.println(sys_name);

				f.transferTo(new File(realPath + File.separator + sys_name));
				dto.setNotice_img(sys_name);
			}
		}

		return noticeDao.insertNotice(dto);
	}

	public int modifyNotice(NoticeDTO dto, String realPath, MultipartFile[] file) throws Exception {
		File realPathFile = new File(realPath);
		if (!realPathFile.exists()) {
			realPathFile.mkdir();
		}

		for (MultipartFile f : file) {
			if (!f.isEmpty()) {
				String ori_name = f.getOriginalFilename();
				String sys_name = UUID.randomUUID() + "_" + ori_name;
				System.out.println(sys_name);

				f.transferTo(new File(realPath + File.separator + sys_name));
				dto.setNotice_img(sys_name);
			}
		}

		return noticeDao.modifyNotice(dto);
	}

	public int deleteNotice(int notice_seq) throws Exception {
		return noticeDao.deleteNotice(notice_seq);
	}
	
	public int deleteChecked(String[] chk_Val) throws Exception{
		return noticeDao.deleteChecked(chk_Val);
	}

	// -------------------- 페이징부분 -------------------------------------------
	private int recordCntPage = 10;
	private int naviCntPage = 5;

	private int[] getPageInfromations(int currentPage) throws Exception {

		int recordTototalCnt = noticeDao.getNoticeCount(); // 해당 카테고리의 전체 데이터의 수

		int pageTotalCnt; // 총 페이지 수
		if ((recordTototalCnt % recordCntPage) == 0) {
			pageTotalCnt = recordTototalCnt / recordCntPage;
		} else {
			pageTotalCnt = (recordTototalCnt / recordCntPage) + 1;
		}

		// 현재 페이지에 대한 안전 장치
		if (currentPage >= pageTotalCnt) { // currentPage가 높은 수일 경우 해결
			currentPage = pageTotalCnt;
		} else if (currentPage <= 0) { // currentPage가 낮은 수일 경우 해결
			currentPage = 1;
		}

		int[] pageInfromations = { currentPage, pageTotalCnt };

		return pageInfromations;
	}

	// 검색시 사용될 메서드
	private int[] getSearchPageInfromations(String keyword, int currentPage) throws Exception {

		int recordTototalCnt = noticeDao.getNoticeCountBySearch(keyword); // 검색한 전체 데이터의 수

		int pageTotalCnt; // 총 페이지 수
		if ((recordTototalCnt % recordCntPage) == 0) {
			pageTotalCnt = recordTototalCnt / recordCntPage;
		} else {
			pageTotalCnt = (recordTototalCnt / recordCntPage) + 1;
		}

		// 현재 페이지에 대한 안전 장치
		if (currentPage >= pageTotalCnt) { // currentPage가 높은 수일 경우 해결
			currentPage = pageTotalCnt;
		} else if (currentPage <= 0) { // currentPage가 낮은 수일 경우 해결
			currentPage = 1;
		}

		int[] pageInfromations = { currentPage, pageTotalCnt };

		return pageInfromations;
	}

	public HashMap<String, Object> getPageNavi(int currentPage) throws Exception {

		currentPage = getPageInfromations(currentPage)[0]; // 현재페이지 안전장치
		int pageTotalCnt = getPageInfromations(currentPage)[1]; // 총 페이지 수

		// ----------------------------------------------------------------------------

		// 시작 네비 페이지, 끝 네비 페이지
		int startNavi = ((currentPage - 1) / naviCntPage) * naviCntPage + 1; // 아래 표시될 시작하는 페이지
		int endNavi = startNavi + (naviCntPage - 1); // 아래 표시될 끝나는 페이지
		if (endNavi >= pageTotalCnt) { // 끝 페이지 버튼이 총 페이지를 넘어설 경우
			endNavi = pageTotalCnt;
		}

		// 이전, 다음 버튼을 띄울지 판단하는 변수
		boolean needPrev = true; // 이전 버튼
		boolean needNext = true; // 다음 버튼

		if (startNavi <= 1) // 처음일때 이전버튼 없음
			needPrev = false;
		if (endNavi >= pageTotalCnt) // 마지막일때 다음버튼 없음
			needNext = false;

		// 키 값 밸류값으로 담음
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("startNavi", startNavi);
		map.put("endNavi", endNavi);
		map.put("needPrev", needPrev);
		map.put("needNext", needNext);
		map.put("currentPage", currentPage);

		return map;
	}

	// 검색 시 사용 메서드
	public HashMap<String, Object> getPageNaviBySearch(String keyword, int currentPage) throws Exception {

		currentPage = getSearchPageInfromations(keyword, currentPage)[0]; // 현재페이지 안전장치
		int pageTotalCnt = getSearchPageInfromations(keyword, currentPage)[1]; // 총 페이지
																												// 수

		// ----------------------------------------------------------------------------

		// 시작 네비 페이지, 끝 네비 페이지
		int startNavi = ((currentPage - 1) / naviCntPage) * naviCntPage + 1; // 아래 표시될 시작하는 페이지
		int endNavi = startNavi + (naviCntPage - 1); // 아래 표시될 끝나는 페이지
		if (endNavi >= pageTotalCnt) { // 끝 페이지 버튼이 총 페이지를 넘어설 경우
			endNavi = pageTotalCnt;
		}

		// 이전, 다음 버튼을 띄울지 판단하는 변수
		boolean needPrev = true; // 이전 버튼
		boolean needNext = true; // 다음 버튼

		if (startNavi <= 1) // 처음일때 이전버튼 없음
			needPrev = false;
		if (endNavi >= pageTotalCnt) // 마지막일때 다음버튼 없음
			needNext = false;

		// 키 값 밸류값으로 담음
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("startNavi", startNavi);
		map.put("endNavi", endNavi);
		map.put("needPrev", needPrev);
		map.put("needNext", needNext);
		map.put("currentPage", currentPage);

		return map;
	}

	public List<NoticeDTO> selectAll(int currentPage) throws Exception {
		int recordTototalCnt = noticeDao.getNoticeCount(); // 해당 조건에 맞는 데이터의 수
		currentPage = getPageInfromations(currentPage)[0]; // 현재페이지로 일어난 오류를 방지

		// ----------------------------------------------------------------------------

		int startRange = ((currentPage - 1) * recordCntPage) + 1; // 보여지는 데이터 시작
		int endRange = currentPage * recordCntPage; // 보여지는 데이터 끝
		if (endRange >= recordTototalCnt) { // 총 데이터를 넘어설 시 최대값 설정
			endRange = recordTototalCnt;
		}

		List<NoticeDTO> list = noticeDao.selectAll(startRange, endRange); // 범위에있는 값을 list로 가져옴
		return list;
	}
	
	// 검색시 불러올 제품 List
	public List<NoticeDTO> getSearchList(String keyword, int currentPage) throws Exception{
		System.out.println(keyword);
		int recordTototalCnt = noticeDao.getNoticeCountBySearch(keyword);
		currentPage = getSearchPageInfromations(keyword, currentPage)[0];
		
		int startRange = ((currentPage - 1) * recordCntPage) + 1;
		int endRange = currentPage * recordCntPage;
		if(endRange >= recordTototalCnt) {
			endRange = recordTototalCnt;
		}
		
		List<NoticeDTO> list = noticeDao.selectNoticeBySearch(keyword, startRange, endRange);
		return list;
	}
}
