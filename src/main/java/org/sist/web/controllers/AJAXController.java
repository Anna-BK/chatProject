package org.sist.web.controllers;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.io.IOUtils;
import org.sist.web.service.ChatRoomService;
import org.sist.web.util.MediaUtils;
import org.sist.web.util.UploadFileUtils;
import org.sist.web.vo.CalendarVO;
import org.sist.web.vo.ChatVoteVO;
import org.sist.web.vo.VoteResultVO;
import org.sist.web.vo.VoteVO;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

@RestController
@RequestMapping("/ajax")
public class AJAXController {

	@Inject
	private ChatWebSocketHandler chatHandler;
	@Inject
	private ChatRoomService service;
	
	private String uploadPath = "C:\\Upload";
	
	@RequestMapping("/members")
	public ArrayList<String> getMembers(String roomnumber) {
		
		Map<String, ArrayList<String>> map = chatHandler.getRoomMembers();
		Map<String, String>map2 = chatHandler.getUserSession();
		ArrayList<String> listroomname = map.get(roomnumber);
		ArrayList<String> list = new ArrayList<String>();
		
		Iterator<String>ir = listroomname.iterator();
		while (ir.hasNext()) {
			String session = ir.next();
			list.add(map2.get(session));
		}
		
		return list;
	}
	
	@RequestMapping("/roomlist")
	public List<Object> getRoomList(String roomtheme) throws Exception{
		
		List<Object>list = service.getRoomList(roomtheme);
		
		return list;
	}
	
	@RequestMapping("/createVote")
	public List<Object> createVote(String[] vote) throws Exception{
		
		System.out.println(vote.toString());
		
		ChatVoteVO vo = new ChatVoteVO();
		vo.setRoomnumber(vote[0]);
		vo.setVoteTitle(vote[1]);
		vo.setSub1(vote[2]);
		vo.setSub2(vote[3]);
		vo.setSub3(vote[4]);
		vo.setSub4(vote[5]);
		
		service.createVote(vo);
		List<Object>list = new ArrayList<Object>();
		
		return list;
	}

	
	@RequestMapping("/votelist")
	public List<Object> voteList(String roomnumber) throws Exception{
		
		List<Object> list = service.getVotes(roomnumber);
		
		return list;
	}
	
	@RequestMapping("/voteComplete")
	public List<Object> voteComplete(String val, String votenumber, String userid) throws Exception{
		
		VoteVO vo = new VoteVO();
		vo.setUserid(userid);
		vo.setVote(val);
		vo.setVotenumber(votenumber);
		
		service.insertVote(vo);
		
		List<Object>list = new ArrayList<Object>();
		return list;
	}
	
	@RequestMapping("/voteResult")
	public VoteResultVO voteResult(String votenumber, String [] vote) throws Exception{
		
		ChatVoteVO vo = new ChatVoteVO();
		vo.setSub1(vote[0]);
		vo.setSub2(vote[1]);
		vo.setSub3(vote[2]);
		vo.setSub4(vote[3]);
		vo.setVotenumber(votenumber);
		
		VoteResultVO vvo = service.getVoteResult(vo);
		
		return vvo;
	}
	
	
	
	// Calendar
	@RequestMapping(value = "/createCal")
	public HashMap<String, Object> register( CalendarVO vo ) {

		try {
			service.createCal(vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("result", "success");

		return map;
		
	}
	
	@ResponseBody
	@RequestMapping(value = "/listCal")
	public List<Object> listCal(String roomnumber) throws Exception{
		
		//System.out.println(roomnumber);

		System.out.println("listCal 호출");
		
		List<Object>list = service.listCal(roomnumber);

		return list ;
		
	}
	

	@RequestMapping(value = "/delCal")
	public ModelAndView delCal( String calno,String roomnumber ) throws Exception{

		service.delCal(calno);
		
		return new ModelAndView("redirect:" + "/c/chat?roomnumber="+roomnumber);

		
	}
	
 //파일 업로드	
	
	
	@RequestMapping(value = "/upload",
			method = RequestMethod.POST,
			produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> upload(MultipartFile file) throws IOException{
		
		System.out.println("upload 호출");
		System.out.println("originalName:"+file.getOriginalFilename());
		System.out.println("size:"+file.getSize());
		System.out.println("contentType:"+file.getContentType());
		
		
		return  new ResponseEntity<>(UploadFileUtils.uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes()), HttpStatus.CREATED);
	}
	
	
	@ResponseBody
	@RequestMapping("/displayFile")
	public ResponseEntity<byte[]> displayFile(String fileName) throws IOException{
		
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		
		System.out.println("fileName:"+fileName);
		
		try {
			
		String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
		
		MediaType mType = MediaUtils.getMediaType(formatName);
		
		HttpHeaders headers = new HttpHeaders();
		
		in = new FileInputStream(uploadPath+fileName);
		
		
		//MIME 타입 지정
		if (mType!=null) {  //이미지 파일 일 경우 
			headers.setContentType(mType);
		} else { 
			fileName = fileName.substring(fileName.indexOf("_")+1);
			headers.setContentType(MediaType.APPLICATION_OCTET_STREAM); // 다운로드용으로 사용되는 MIME 타입
			headers.add("Content-Disposition", "attachment; filename=\"" +
						new String(fileName.getBytes("utf-8"), "ISO-8859-1")+"\"");  // 보낼 파일 이름 한글 인코딩 처리
		}
		
		entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in),
				headers,
				HttpStatus.CREATED);
			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		}finally {
			in.close();
		}
		
		return entity;
	}
	
	
	@ResponseBody
	@RequestMapping(value="/deleteFile",method = RequestMethod.POST)
	public ResponseEntity<String> deleteFile(String fileName){
		
	String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
		
	MediaType mType = MediaUtils.getMediaType(formatName);
	if (mType!=null) {  //이미지 파일 일 경우 
		
		String front = fileName.substring(0, 12);
		String end = fileName.substring(14);
		
		new File(uploadPath+(front+end).replace('/', File.separatorChar)).delete();
	}
	
		new File(uploadPath+fileName.replace('/', File.separatorChar)).delete();
	
	
	return new ResponseEntity<String>("deleted",HttpStatus.OK);
	
	}
	
	
	
	
	
}
