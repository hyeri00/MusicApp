//
//  TrackManager.swift
//  AppleMusicStApp
//
//  Created by 혜리 on 2022/05/19.
//

import UIKit
import AVFoundation

class TrackManager {
    // TODO : 프로퍼티 정의하기 - 트랙들, 앨범들, 오늘의 곡

    var tracks: [AVPlayerItem] = []
    var albums: [Album] = []
    var todaysTrack: AVPlayerItem?
    
    // TODO : 생성자 정의하기
    init() {
        let tracks = loadTracks()
        self.tracks = tracks
        self.albums = loadAlbums(tracks: tracks)
        self.todaysTrack = self.tracks.randomElement()
    }
    
    // TODO : 앨범 로딩 메소드 구현
    func loadAlbums(tracks: [AVPlayerItem]) -> [Album] {
        let trackList = tracks.compactMap { $0.convertToTrack() }
        let albumDics = Dictionary(grouping: trackList, by: { track in  track.albumName })
        var albums: [Album] = []
        for (key, value) in albumDics {
            let title = key
            let tracks = value
            let album = Album(title: title, tracks: tracks)
            albums.append(album)
        }
        return albums
    }
    
    // TODO : 트랙 로드하기
    func loadTracks() -> [AVPlayerItem] {
        // 파일들 읽어서 AVPlayerItem 만들기
        let urls = Bundle.main.urls(forResourcesWithExtension: "mp3", subdirectory: nil) ?? []
        let tracks = urls.map { AVPlayerItem(url: $0) }
        return tracks
    }
    
    // TODO : 인덱스에 맞는 트랙 로드하기
    func track(at index: Int) -> Track? {
        return tracks[index].convertToTrack()
    }
    
    // TODO : 오늘의 트랙 랜덤으로 선택
    func loadOtherTodaysTrack() {
        self.todaysTrack = self.tracks.randomElement()
    }
}
