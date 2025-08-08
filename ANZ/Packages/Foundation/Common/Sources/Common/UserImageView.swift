import SwiftUI

public struct UserImageView<S: Shape>: View {
    let urlString: String
    var shape: S
    var frameSize: CGSize

    public init(urlString: String, shape: S = Circle(), frameSize: CGSize = CGSize(width: 50, height: 50)) {
        self.urlString = urlString
        self.shape = shape
        self.frameSize = frameSize
    }

    public var body: some View {
        AsyncImage(url: URL(string: urlString)) { image in
            image
                .resizable()
                .scaledToFill()
                .frame(width: frameSize.width, height: frameSize.height)
                .clipShape(shape)
        } placeholder: {
            ProgressView()
                .frame(width: frameSize.width, height: frameSize.height)
        }
    }
}

#Preview {
    UserImageView(urlString: "https://json-server.dev/ai-profiles/5.png")
}
