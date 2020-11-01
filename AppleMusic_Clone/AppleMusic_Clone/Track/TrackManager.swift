//
//  TrackManager.swift
//  AppleMusic_Clone
//
//  Created by 서보경 on 2020/11/01.
//

import UIKit
import AVFoundation

class TrackManager {
    
    var tracks: [AVPlayerItem] = []
    var albums: [Album] = []
    var todaysTrack: AVPlayerItem?
    
    init() {
        let tracks = loadTracks()
        self.tracks = tracks
        self.albums = loadAlbums(tracks: tracks)
        self.todaysTrack = self.tracks.randomElement()
    }
    
    func loadTracks() -> [AVPlayerItem] {
//        파일들 읽어서 AVPlayerItem 만들기
        let urls = Bundle.main.urls(forResourcesWithExtension: "mp3", subdirectory: nil) ?? []
        let items = urls.map { AVPlayerItem(url: $0) }
        
        return items
    }
    
    func track(at index: Int) -> Track? {
        let playerItem = tracks[index]
        return playerItem.convertToTrack()
    }
    
    func loadAlbums(tracks: [AVPlayerItem]) -> [Album] {
        let trackList: [Track] = tracks.compactMap { $0.convertToTrack() }
        let albumDics = Dictionary(grouping: trackList) { track in track.albumName }
        var albums: [Album] = []
        for (key, value) in albumDics {
            let title = key
            let tracks = value
            let album = Album(title: title, tracks: tracks)
            albums.append(album)
        }
        
        return albums
    }
    
    func loadOtherTodaysTrack() {
        
    }
}
