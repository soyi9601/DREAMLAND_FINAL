package com.dreamland.prj.service;

import java.io.IOException;

public interface ImageService {
  
  public byte[] generatePngImage(String empName) throws IOException;

}
