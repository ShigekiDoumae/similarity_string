require "similarity_string/version"

# encoding: utf-8
module SimilarityString
  # Your code goes here...
  class String
    def match_rate(target_string)
      return 0 if self.length <= 0
      self.ngram(target_string).to_f
      #self.split('').select { |s| s.match(/#{target_string.split('')}/) }.size.quo(self.length).to_f
    end

    def match_rate_percent(target_string)
      match_rate(target_string) * 100
    end

    #"frente.co.jp".levenshtein_distance("webmaster@frente.co.jp") => 10
    #"webmaster@frente.co.jp".levenshtein_distance("frente.co.jp") => 10
    def levenshtein_distance(target_string)
      col, row = self.size + 1, target_string.size + 1
      d = row.times.inject([]){|a, i| a << [0] * col }
      col.times {|i| d[0][i] = i }
      row.times {|i| d[i][0] = i }
      self.size.times do |i1|
        target_string.size.times do |i2|
          cost = self[i1] == target_string[i2] ? 0 : 1
          x, y = i1 + 1, i2 + 1
          d[y][x] = [d[y][x-1]+1, d[y-1][x]+1, d[y-1][x-1]+cost].min
        end
      end
      d[target_string.size][self.size]
    end

    #文字数の少ない方を基準に動かすとしたら、こっちの方がいいかも
    #"frente.co.jp".ngram("webmaster@frente.co.jp") => 1.0
    #"webmaster@frente.co.jp".ngram("frente.co.jp") => 0.5
    def ngram(string, part_len = 3)
      string = string.dup.gsub(/[\s\n　]+/u, "")
      strlen = string.split(//u).length
      points = []
      source = self.gsub(/[\s\n　]+/u, "")
      srcarr = source.split(//u)
      sourcelen = srcarr.length
      return nil if part_len > sourcelen
      return nil if part_len > strlen
      [string, source].each do|cmpstr|
        counter = 0.0
        (0..(sourcelen - part_len)).each do|start|
          part = srcarr[start, part_len].join("")
          hit = cmpstr.scan(/#{Regexp.quote(part)}/).size
          counter += hit
        end
        points << counter
      end
      points.shift / points.shift
    end
  end

end
