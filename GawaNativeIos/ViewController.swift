import UIKit

class ViewController: UIViewController, UIWebViewDelegate {
  var webview: UIWebView = UIWebView()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

    self.webview.frame = self.view.bounds
    self.webview.delegate = self;
    self.view.addSubview(self.webview)

    let path = NSBundle.mainBundle().pathForResource("index", ofType: "html")!
    let url = NSURL(string: path)!
    let urlRequest = NSURLRequest(URL: url)
    self.webview.loadRequest(urlRequest)
  }

  func webView(webView: UIWebView!, shouldStartLoadWithRequest request: NSURLRequest!, navigationType: UIWebViewNavigationType) -> Bool {
    let kScheme = "native://";
    let url = request.URL.absoluteString
    if url!.hasPrefix(kScheme) {
      evaluateJs("addTextNode('\(url!) ');")
      return false
    }
    return true
  }

  func evaluateJs(script: String) -> String? {
    return self.webview.stringByEvaluatingJavaScriptFromString(script)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}
