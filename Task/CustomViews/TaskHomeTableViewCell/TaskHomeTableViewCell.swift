//
//  TaskHomeTableViewCell.swift
//  Task
//
//  Created by Armaghan  on 4/19/21.
//
import Foundation
import UIKit

class TaskHomeTableViewCell: UITableViewCell
{
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var progressBarImage: UIProgressView!
    @IBOutlet weak var imgCell: UIImageView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.viewCellSetup()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //MARK:- View Cell Setup
    func viewCellSetup()
    {
        self.progressBarImage.progress = 0.0

    }
    //MARK:- Populate Cell Data
    func populateCells(imgURL: URL)
    {
        self.download(url: imgURL)
    }
    func download(url: URL) {
        let configuration = URLSessionConfiguration.default
        let session = Foundation.URLSession(configuration: configuration, delegate: self, delegateQueue: OperationQueue.main)
        let downloadTask = session.downloadTask(with: url)
        downloadTask.resume()
    }
}
//MARK:- URLSession Delegates and download progress
extension TaskHomeTableViewCell : URLSessionDownloadDelegate
{
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL)
    {
        let data = readDownloadedData(of: location)
        setImageToImageView(from: data)
    }
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64)
    {
        let totalDownloaded = Float(totalBytesWritten / totalBytesExpectedToWrite)
        DispatchQueue.main.async
        {
            self.progressBarImage.progress = totalDownloaded
        }
    }
    // MARK: set image to image view
    func setImageToImageView(from data: Data?) {
        guard let imageData = data else { return }
        guard let image = getUIImageFromData(imageData) else { return }
        
        DispatchQueue.main.async {
            self.progressBarImage.isHidden = true
            self.imgCell.image = image
        }
    }
    func getUIImageFromData(_ data: Data) -> UIImage? {
        return UIImage(data: data)
    }
    func readDownloadedData(of url: URL) -> Data? {
        do {
            let reader = try FileHandle(forReadingFrom: url)
            let data = reader.readDataToEndOfFile()
            return data
        } catch {
            print(error)
            return nil
        }
    }
    
}
