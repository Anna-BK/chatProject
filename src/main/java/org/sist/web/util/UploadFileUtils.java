package org.sist.web.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.springframework.util.FileCopyUtils;

public class UploadFileUtils {
	
	
	public static String uploadFile(String uploadPath, 
			String originalName,
			byte[] fileData) throws IOException {
		// 1   uuid + originalfileName == 업로드용 fileName
		
		UUID uid = UUID.randomUUID();
		
		String savedName = uid.toString()+"_"+originalName;
		
		// 2   uploadPath + 년/월/일 폴더 
		String savedPath = calcPath(uploadPath);
		
		File target = new File(uploadPath+savedPath, savedName);
		
		FileCopyUtils.copy(fileData, target);
		
		String formatName = originalName.substring(originalName.lastIndexOf(".")+1);
		
		String uploadedFileName = null;

		// 폴더에 업로드용 파일이름으로 파일 저장 

		if(MediaUtils.getMediaType(formatName) != null){
			uploadedFileName = makeThumbnail(uploadPath, savedPath, savedName);}
		else{
			uploadedFileName = makelcon(uploadPath, savedPath, savedName);
		}
		return uploadedFileName;

	}
	
	
	private static String makelcon(String uploadPath, String path, String fileName) {
		
		String iconName = uploadPath+path+File.separator+fileName;
	
		return iconName.substring( uploadPath.length()).replace(File.separatorChar, '/');
	}


	// 2   uploadPath + 년/월/일 폴더 
	private static String calcPath(String uploadPath) {
		Calendar cal = Calendar.getInstance();
		
		String yearPath = File.separator+cal.get(Calendar.YEAR);
		String monthPath = yearPath +
				File.separator+
				new DecimalFormat("00").format(cal.get(Calendar.MONTH)+1);
		
		String datePath = monthPath +
				File.separator +
				new DecimalFormat("00").format(cal.get(Calendar.DATE));
		
		// 폴더 생성
		
		makeDir(uploadPath, yearPath, monthPath, datePath);
		
		System.out.println(datePath);
		
		return datePath;
	}


	private static void makeDir(String uploadPath, String...paths) {
		if (new File(paths[paths.length-1]).exists()) {
			return;
		}
		
		for (String path : paths) {
			
			File dirPath = new File(uploadPath+ path);
			
			if (!dirPath.exists()) {
				dirPath.mkdirs();
			}
		}

	}
	
	public static String makeThumbnail(
			String uploadPath,
			String path,
			String fileName
			) throws IOException {
		
		BufferedImage sourceImg = ImageIO.read(new File(uploadPath+path, fileName ));
		
		BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT,100);
		
		String thumbnailName = 
				uploadPath + path + File.separator + "s_" + fileName;
		
		File newFile = new File(thumbnailName);
		
		String formatName  =
				fileName.substring(fileName.lastIndexOf(".")+1);  // .png, .jpg ... 
		
		ImageIO.write(destImg, formatName.toUpperCase(), newFile);
		
		return thumbnailName.substring(uploadPath.length()).replace(File.separatorChar, '/');
		
	}
	
	

}
