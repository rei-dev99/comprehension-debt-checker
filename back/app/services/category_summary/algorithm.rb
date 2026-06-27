module CategorySummary
  class Algorithm
    def initialize(score)
      @score = score
    end

    def call
      build_algorithm_summary(@score)
    end

    private

    def build_algorithm_summary(score)
      if score >= 12
        "基本的なアルゴリズムを理解できています。今後は配列やハッシュ、探索や並び替えなどを実際に実装しながら理解を深めていきましょう。"
      elsif score >= 9
        "基本的な考え方は身についています。簡単な問題を自分で考えて解く機会を増やすと、さらに理解が深まります。"
      else
        "アルゴリズムの理解はこれから伸ばせる段階です。まずはif文・繰り返し処理・配列など、基本的な処理を自分で書く練習から始めましょう。"
      end
    end
  end
end
