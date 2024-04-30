//
//  String+Extension.swift
//  MoviesApp
//
//  Created by Hina on 2024/04/29.
//  Copyright © 2024 Mohammad Azam. All rights reserved.
//

import Foundation

extension String {
    /// この文字列から前後の空白や改行を削除し、その後でURLホストに許可されている文字だけを含むようにエンコードします。
    /// エンコードに失敗した場合は元の文字列をそのまま返します。
    func trimmedAndEscaped() -> String {
        // self から空白と改行をトリミング
        let trimmedString = self.trimmingCharacters(in: .whitespacesAndNewlines)
        // トリミングした文字列をURL用にエスケープ処理
        return trimmedString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
    }
}
