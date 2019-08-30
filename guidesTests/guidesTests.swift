//
//  guidesTests.swift
//  guidesTests
//
//  Created by Marcus Kuquert on 8/30/19.
//  Copyright © 2019 Marcus V Kuquert. All rights reserved.
//

import XCTest

@testable import guides

class guidesTests: XCTestCase {
    var guides: [Guide] = []
    
    override func setUp() {
        let promisse = expectation(description: "Wait to load resource from json")
        
        GuideFacade.sharedLocal.loadUpcomingGuides { (guidesResponse, error) in
            guard let guides = guidesResponse?.data else {
                XCTFail("Invalid guides response")
                return
            }
            
            self.guides = guides
            promisse.fulfill()
        }
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }

    func testGuidesGrouping() {
        let groupedGudies = ViewController.groupByDate(guides: guides)
        XCTAssertEqual(groupedGudies.keys.count, 5)
        XCTAssertEqual(groupedGudies["Sep 02, 2019"]?.count, 2)
        XCTAssertEqual(groupedGudies["Sep 03, 2019"]?.count, 6)
        XCTAssertEqual(groupedGudies["Sep 04, 2019"]?.count, 3)
        XCTAssertEqual(groupedGudies["Sep 05, 2019"]?.count, 1)
        XCTAssertEqual(groupedGudies["Sep 06, 2019"]?.count, 3)
    }
    
    func testSectionHeader() {
        let sectionHeader = SectionHeaderView()
        sectionHeader.startDate = "Sep 02, 2019"
        XCTAssertEqual(sectionHeader.titleLabel.text, "Starting on Sep 02, 2019")
    }
    
    func testGuideCell() {
        var guide = Guide(
            startDate: "Sep 02, 2019",
            endDate: "Sep 04, 2019",
            name: "ASI 2019",
            url: "/guide/116338",
            venue: Venue(city: nil, state: nil),
            objType: "guide",
            icon: "https://s3.amazonaws.com/media.guidebook.com/service/gvFhzPv3qVpp9GG6cIkq7bp4IGNNOsPnCbmudrVI/logo.png"
        )
        
        let guideCell = GuideTableViewCell()
        guideCell.guide = guide
        
        XCTAssertEqual(guideCell.detailLable.text, "Ending on Sep 04, 2019")
        XCTAssertFalse(guideCell.calendarIcon.isHidden)
        
        XCTAssertEqual(guideCell.locationLable.text, nil)
        XCTAssertTrue(guideCell.locationIcon.isHidden)
        
        
        guide.venue = Venue(city: "Austin", state: "TX")
        guideCell.guide = guide
        
        XCTAssertEqual(guideCell.locationLable.text, "Austin, TX")
        XCTAssertFalse(guideCell.locationIcon.isHidden)
    }
    
    func testSectionHeaderView() {
        
    }
}
