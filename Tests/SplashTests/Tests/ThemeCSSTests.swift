import Foundation
import XCTest
import Splash

final class ThemeCSSTests: SplashTestCase {
    private var theme: Theme!

    override func setUp() {
        super.setUp()
        theme = .sundellsColors()
    }

    func testBasicGeneration() {
        let css = theme.toCSS()

        let expectation = """
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

        pre {
            background-color: #191919ff;
        }

        pre code {
            color: #a8bdbdff;
        }

        pre code .call {
            color: #338fe6ff;
        }

        pre code .comment {
            color: #6b8a94ff;
        }

        pre code .dotAccess {
            color: #91b300ff;
        }

        pre code .keyword {
            color: #e8338aff;
        }

        pre code .number {
            color: #db7057ff;
        }

        pre code .preprocessing {
            color: #b58a00ff;
        }

        pre code .property {
            color: #21ab9eff;
        }

        pre code .string {
            color: #fa631fff;
        }

        pre code .type {
            color: #8282c9ff;
        }

        """
        
        XCTAssertEqual(css, expectation)
    }

    func testAllTestsRunOnLinux() {
        XCTAssertTrue(TestCaseVerifier.verifyLinuxTests((type(of: self)).allTests))
    }
}

extension ThemeCSSTests {
    static var allTests: [(String, TestClosure<ThemeCSSTests>)] {
        return [
            ("testBasicGeneration", testBasicGeneration)
        ]
    }
}










































































