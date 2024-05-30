package com.dreamland.prj.service;

public interface RefreshService {
  void addRefreshToken(String username, String refresh, String expiration);
  void deleteByRefresh(String refresh);

  int searchRefreshToken(String refresh);
}
