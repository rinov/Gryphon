// https://github.com/Quick/Quick

import Quick
import Nimble
import Gryphon

class TableOfContentsSpec: QuickSpec {
    override func spec() {
        describe("TEST") {

            it("is true") {
                expect(1) == 1
            }

            
            context("these will pass") {

                it("will eventually pass") {

                    var time = "passing"

                    dispatch_async(dispatch_get_main_queue()) {
                        time = "done"
                    }

                    waitUntil { done in
                        NSThread.sleepForTimeInterval(0.5)
                        expect(time) == "done"

                        done()
                    }
                }
            }
        }
    }
}
