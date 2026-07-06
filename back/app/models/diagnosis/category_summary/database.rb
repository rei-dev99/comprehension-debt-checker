module Diagnosis
  module CategorySummary
    class Database
      def initialize(score)
        @score = score
      end

      def call
        build_database_summary(@score)
      end

      private

      def build_database_summary(score)
        if score >= 12
          "データベースの基礎は身についています。テーブル設計やリレーションを意識しながら開発を続けると、さらに実践力が身につきます。"
        elsif score >= 9
          "基本的な知識は身についています。実際にSQLを書いたり、データの流れを意識しながら学ぶと理解がより深まります。"
        else
          "データベースの基礎を復習すると理解が深まりそうです。まずはテーブル・主キー・外部キーの役割を整理するところから始めてみましょう。"
        end
      end
    end
  end
end
