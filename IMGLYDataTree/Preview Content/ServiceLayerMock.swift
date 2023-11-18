//
//  ServiceLayerMock.swift
//  IMGLYDataTree
//
//  Created by Rafael Moura on 18/11/2023.
//

import Foundation

final class ServiceLayerMock: ServiceLayerProtocol {

    static let instance = ServiceLayerMock()

    func requestTree() async throws -> [TreeNode] {

        return [TreeNode(label: "Test", id: "123",
                         children: [TreeNode(label: "Test_child1", id: "456",
                                             children: [TreeNode(label: "Test_child2", id: "456", children: [])])
                         ]),
                TreeNode(label: "Test1", id: "03203i",
                                 children: [TreeNode(label: "Test1_child1", id: "0954",
                                                     children: [TreeNode(label: "Test1_child2", id: "039548", children: [])])
                                 ])
              ]
    }
    
    func requestEntryDetails(id: String) async throws -> EntryDetail {
        
        return EntryDetail(id: "e20d9958-abff-59f4-8561-0c76292dad73",
                           createdAt: Date(),
                           createdBy: "creator@imgly.com",
                           lastModifiedAt: Date(),
                           lastModifiedBy: "modifier@imgly.com",
                           description: "Rebongig joeto gusku tiwwa vapumed cupi ni dep tijur uc rifrezlap peha dobpu gonnehe jija doduvce. Mis silot welug oho gitofpud cif eh ec awara voc volupif fi soimja. Ovi sovwombov farol bajifo vumutu zitoci eb hor dujot efinal fikrubebi wakimah toh rasovumi tipdolum ga wakorca ma. Azonev jajrali atu sufvegta ozudogin iplecvit futaki segjajem kowrize reroref lacevlu gen soufino hud defize filtimot.")
    }
}
