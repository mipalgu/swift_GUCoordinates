/*
 * gu_field_coordinate.swift 
 * GUCoordinates 
 *
 * Created by Callum McColl on 10/07/2020.
 * Copyright © 2020 Callum McColl. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above
 *    copyright notice, this list of conditions and the following
 *    disclaimer in the documentation and/or other materials
 *    provided with the distribution.
 *
 * 3. All advertising materials mentioning features or use of this
 *    software must display the following acknowledgement:
 *
 *        This product includes software developed by Callum McColl.
 *
 * 4. Neither the name of the author nor the names of contributors
 *    may be used to endorse or promote products derived from this
 *    software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER
 * OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * -----------------------------------------------------------------------
 * This program is free software; you can redistribute it and/or
 * modify it under the above terms or under the terms of the GNU
 * General Public License as published by the Free Software Foundation;
 * either version 2 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, see http://www.gnu.org/licenses/
 * or write to the Free Software Foundation, Inc., 51 Franklin Street,
 * Fifth Floor, Boston, MA  02110-1301, USA.
 *
 */

import CGUCoordinates

extension gu_field_coordinate: Equatable {

    public static func == (lhs: gu_field_coordinate, rhs: gu_field_coordinate) -> Bool {
        return lhs.position == rhs.position && lhs.heading == rhs.heading
    }

}

extension gu_field_coordinate: Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.position)
        hasher.combine(self.heading)
    }

}

extension gu_field_coordinate: Codable {

    enum CodingKeys: String, CodingKey {
        case position
        case heading
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let position = try values.decode(gu_cartesian_coordinate.self, forKey: .position)
        let heading = try values.decode(degrees_t.self, forKey: .heading)
        self.init(position: position, heading: heading)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.position, forKey: .position)
        try container.encode(self.heading, forKey: .heading)
    }

}

extension gu_field_coordinate: AdditiveArithmetic {
    
    public static var zero: gu_field_coordinate {
        return gu_field_coordinate()
    }

    public static func + (lhs: gu_field_coordinate, rhs: gu_field_coordinate) -> gu_field_coordinate {
        return gu_field_coordinate(position: lhs.position + rhs.position, heading: lhs.heading + rhs.heading)
    }

    public static func += (lhs: inout gu_field_coordinate, rhs: gu_field_coordinate) {
        lhs.position += rhs.position
        lhs.heading += rhs.heading
    }

    public static func - (lhs: gu_field_coordinate, rhs: gu_field_coordinate) -> gu_field_coordinate {
        return gu_field_coordinate(position: lhs.position - rhs.position, heading: lhs.heading - rhs.heading)
    }

    public static func -= (lhs: inout gu_field_coordinate, rhs: gu_field_coordinate) {
        lhs.position -= rhs.position
        lhs.heading -= rhs.heading
    }
    
}
