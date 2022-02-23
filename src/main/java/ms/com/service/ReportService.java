package ms.com.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ms.com.dao.ReportDAO;
import ms.com.dto.ReportDTO;

@Service
public class ReportService {
	@Autowired
	private ReportDAO reportDao;
	
	// 같은 아이디로 같은 리뷰에 이미 신고가 존재하는지 파악
	public int alreadyReport(ReportDTO dto) throws Exception{
		return reportDao.alreadyReport(dto);
	}
	
	public int insertReport(ReportDTO dto) throws Exception {
		return reportDao.insertReport(dto);
	}

	public int deleteReport(int report_seq) throws Exception {
		return reportDao.deleteReport(report_seq);
	}

	public int deleteChecked(String[] chk_Val) throws Exception {
		return reportDao.deleteChecked(chk_Val);
	}
	
	// 신고번호의 리뷰번호를 반환
	public int selectReview_seqByReport_seq(int report_seq) throws Exception {
		return reportDao.selectReview_seqByReport_seq(report_seq);
	}

	// -------------------- 페이징부분 -------------------------------------------
	private int recordCntPage = 10;
	private int naviCntPage = 5;

	private int[] getPageInfromations(int currentPage) throws Exception {

		int recordTototalCnt = reportDao.getReportCount(); // 해당 카테고리의 전체 데이터의 수

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
	private int[] getSearchPageInfromations(String category, String searchOption, String keyword, int currentPage)
			throws Exception {

		int recordTototalCnt = reportDao.getReportCountBySearch(category, searchOption, keyword); // 검색한 전체
																									// 데이터의 수

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
	public HashMap<String, Object> getPageNaviBySearch(String category, String searchOption, String keyword,
			int currentPage) throws Exception {

		currentPage = getSearchPageInfromations(category, searchOption, keyword, currentPage)[0]; // 현재페이지 안전장치
		int pageTotalCnt = getSearchPageInfromations(category, searchOption, keyword, currentPage)[1]; // 총 페이지
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

	public List<ReportDTO> selectAll(int currentPage) throws Exception {
		int recordTototalCnt = reportDao.getReportCount();
		currentPage = getPageInfromations(currentPage)[0];

		int startRange = ((currentPage - 1) * recordCntPage) + 1;
		int endRange = currentPage * recordCntPage;
		if (endRange >= recordTototalCnt) {
			endRange = recordTototalCnt;
		}

		List<ReportDTO> list = reportDao.selectAll(startRange, endRange);
		return list;
	}

	// 검색시 불러올 신고 List
	public List<ReportDTO> getSearchList(String category, String searchOption, String keyword, int currentPage)
			throws Exception {
		int recordTototalCnt = reportDao.getReportCountBySearch(category, searchOption, keyword);
		currentPage = getSearchPageInfromations(category, searchOption, keyword, currentPage)[0];

		int startRange = ((currentPage - 1) * recordCntPage) + 1;
		int endRange = currentPage * recordCntPage;
		if (endRange >= recordTototalCnt) {
			endRange = recordTototalCnt;
		}

		List<ReportDTO> list = reportDao.selectReportBySearch(category, searchOption, keyword, startRange,
				endRange);
		return list;
	}

}
