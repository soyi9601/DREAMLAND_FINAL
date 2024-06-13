package com.dreamland.prj.service;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;

import javax.imageio.ImageIO;

import org.springframework.stereotype.Service;

@Service
public class ImageServiceImpl implements ImageService {

  @Override
  public byte[] generatePngImage(String empName) throws IOException {
    int width = 200;
    int height = 200;
    BufferedImage bufferedImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_ARGB);
    Graphics2D g2d = bufferedImage.createGraphics();

    // 배경색 설정
    g2d.setColor(Color.WHITE);
    g2d.fillRect(0, 0, width, height);

    // 검정색 테두리와 흰색 내부를 가진 원 그리기
    g2d.setColor(Color.BLACK);
    g2d.setStroke(new BasicStroke(7));
    g2d.drawOval(width / 4, height / 4, width / 2, height / 2);
    g2d.setColor(Color.WHITE);
    g2d.fillOval(width / 4, height / 4, width / 2, height / 2);

    // 텍스트 설정
    g2d.setColor(Color.BLACK);
    g2d.setFont(new Font("맑은고딕", Font.BOLD, 20));
    
    String text = empName;
    FontMetrics fm = g2d.getFontMetrics();
    int textWidth = fm.stringWidth(text);
    int textHeight = fm.getAscent();
    int textX = (width - textWidth) / 2;
    int textY = (height + textHeight) / 2;
    g2d.drawString(text, textX, textY);
    g2d.dispose();

    // 이미지를 ByteArrayOutputStream을 통해 PNG로 변환
    ByteArrayOutputStream baos = new ByteArrayOutputStream();
    ImageIO.write(bufferedImage, "png", baos);
    return baos.toByteArray();
  }
}
