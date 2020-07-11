/**
 *  Splash
 *  Copyright (c) John Sundell 2018
 *  MIT license - see LICENSE.md
 */

import Foundation

/// A theme describes what fonts and colors to use when rendering
/// certain output formats - such as `NSAttributedString`. Several
/// default implementations are provided - see Theme+Defaults.swift.
public struct Theme {
    
    /// What color to use for plain text (no highlighting)
    public var plainTextColor: Color
    /// What color to use for the background
    public var backgroundColor: Color
    /// What color to use for the text's highlighted tokens
    public var tokenColors: [TokenType: Color]
    
    #if os(macOS) || os(iOS)
    /// What font to use to render the highlighted text
    public var font: Font
    
    public init(
        font: Font = .init(size: 12),
        plainTextColor: Color,
        tokenColors: [TokenType: Color],
        backgroundColor: Color = Color(white: 0.12, alpha: 1)
    ) {
        self.font = font
        self.plainTextColor = plainTextColor
        self.tokenColors = tokenColors
        self.backgroundColor = backgroundColor
    }
    #else
    public init(
        plainTextColor: Color,
        tokenColors: [TokenType: Color],
        backgroundColor: Color = Color(white: 0.12, alpha: 1)
    ) {
        self.plainTextColor = plainTextColor
        self.tokenColors = tokenColors
        self.backgroundColor = backgroundColor
    }
    #endif
    
    /// Generates CSS for styling generated code
    ///
    /// Note: font property value is ignored, this method uses predefined layout & fonts
    public func toCSS() -> String {
        """
        pre {
            margin-bottom: 1.5em;
            padding: 16px 0;
            border-radius: 16px;
        }
        
        pre code {
            font-family: monospace;
            display: block;
            padding: 0 20px;
            line-height: 1.4em;
            font-size: 0.95em;
            overflow-x: auto;
            white-space: pre;
            -webkit-overflow-scrolling: touch;
        }
        
        
        """.appending(colorsToCSS())
    }
    
    /// Generates CSS for styling generated code
    public func colorsToCSS() -> String {
        """
        pre {
            background-color: \(backgroundColor.render());
        }
        
        pre code {
            color: \(plainTextColor.render());
        }
        
        
        """.appending(tokenColors.toCSS())
    }
    
}

extension Color {
    public func render() -> String { hex(uppercase: false, hashTagPrefix: true) }
}

extension Dictionary where Key == TokenType, Value == Color {
    /// Generates CSS for styling generated code
    func toCSS() -> String {
        sorted(by: { $0.key.string < $1.key.string })
            .reduce(into: [String]()) { buffer, tokenColor in
                buffer.append(
                    """
                    pre code .\(tokenColor.key.string) {
                        color: \(tokenColor.value.render());
                    }
                    
                    """
                )
            }
            .joined(separator: "\n")
    }
}
