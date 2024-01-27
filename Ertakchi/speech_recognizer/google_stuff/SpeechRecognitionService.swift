// It is my code)


import Foundation
import googleapis

let API_KEY : String = "AIzaSyCTTet_gnCGo4-Ze_NyxNGVF3xd81m84cc"
let HOST = "speech.googleapis.com"

typealias SpeechRecognitionCompletionHandler = (StreamingRecognizeResponse?, NSError?) -> (Void)

class SpeechRecognitionService {
  var sampleRate: Int = 16000
  private var streaming = false
    
    // Property for app's translate screen
    var isTranslatePage: Bool = false
    var translatorLang: String = "uz-UZ"
    

  private var client : Speech!
  private var writer : GRXBufferedPipe!
  private var call : GRPCProtoCall!

  static let sharedInstance = SpeechRecognitionService()

  func streamAudioData(_ audioData: NSData, completion: @escaping SpeechRecognitionCompletionHandler) {
    if (!streaming) {
      // if we aren't already streaming, set up a gRPC connection
      client = Speech(host:HOST)
      writer = GRXBufferedPipe()
      call = client.rpcToStreamingRecognize(withRequestsWriter: writer,
                                            eventHandler:
        { (done, response, error) in
                                              completion(response, error as? NSError)
      })
      // authenticate using an API key obtained from the Google Cloud Console
      call.requestHeaders.setObject(NSString(string:API_KEY),
                                    forKey:NSString(string:"X-Goog-Api-Key"))
      // if the API key has a bundle ID restriction, specify the bundle ID like this
      call.requestHeaders.setObject(NSString(string:Bundle.main.bundleIdentifier!),
                                    forKey:NSString(string:"X-Ios-Bundle-Identifier"))

      print("HEADERS:\(call.requestHeaders)")

      call.start()
      streaming = true

      // send an initial request message to configure the service
      let recognitionConfig = RecognitionConfig()
      recognitionConfig.encoding =  .linear16
      recognitionConfig.sampleRateHertz = Int32(sampleRate)
    
        if isTranslatePage {
            recognitionConfig.languageCode = translatorLang
        } else {
            let language = LanguageManager.getAppLang()
            var appLanguage = "en-US"
            switch language {
            case .English:
                appLanguage = "en-US"
            case .Uzbek:
                appLanguage = "en-US"
            case .lanDesc:
                appLanguage = "en-US"
            }
            recognitionConfig.languageCode = appLanguage
        }
       
        
      recognitionConfig.maxAlternatives = 30
      recognitionConfig.enableWordTimeOffsets = true
        
        let pharasesArray1 = NSMutableArray.init(array: ["book", "fly", "book fly", "go", "back", "go back", "play", "stop", "pause", "VR"])
        let mySpeechContext1 = SpeechContext.init()
        mySpeechContext1.phrasesArray = pharasesArray1
        
        let pharasesArray2 = NSMutableArray.init(array: ["book fly play", "book fly stop", "book fly pause"])
        let mySpeechContext2 = SpeechContext.init()
        mySpeechContext2.phrasesArray = pharasesArray2
        
        recognitionConfig.speechContextsArray = NSMutableArray(array: [mySpeechContext1, mySpeechContext2])

      let streamingRecognitionConfig = StreamingRecognitionConfig()
      streamingRecognitionConfig.config = recognitionConfig
      streamingRecognitionConfig.singleUtterance = false
      streamingRecognitionConfig.interimResults = true

      let streamingRecognizeRequest = StreamingRecognizeRequest()
      streamingRecognizeRequest.streamingConfig = streamingRecognitionConfig

      writer.writeValue(streamingRecognizeRequest)
    }

    // send a request message containing the audio data
    let streamingRecognizeRequest = StreamingRecognizeRequest()
    streamingRecognizeRequest.audioContent = audioData as Data
    writer.writeValue(streamingRecognizeRequest)
  }

  func stopStreaming() {
    if (!streaming) {
      return
    }
    writer.finishWithError(nil)
    streaming = false
  }

  func isStreaming() -> Bool {
    return streaming
  }

}

