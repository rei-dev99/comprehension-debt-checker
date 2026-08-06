require 'rails_helper'

RSpec.describe Result, type: :model do
  describe 'validations' do
    context 'when all attributes are valid' do
      let(:result) { build(:result) }

      it 'is valid' do
        expect(result).to be_valid
      end
    end

    describe 'presence validation' do
      context 'when advices is blank' do
        let(:result) { build(:result, advices: nil) }

        it 'is invalid' do
          expect(result).to be_invalid
        end
      end

      context 'when ai_score is blank' do
        let(:result) { build(:result, ai_score: nil) }

        it 'is invalid' do
          expect(result).to be_invalid
        end
      end

      context 'when algorithm_score is blank' do
        let(:result) { build(:result, algorithm_score: nil) }

        it 'is invalid' do
          expect(result).to be_invalid
        end
      end

      context 'when db_score is blank' do
        let(:result) { build(:result, db_score: nil) }

        it 'is invalid' do
          expect(result).to be_invalid
        end
      end

      context 'when dependency_score is blank' do
        let(:result) { build(:result, dependency_score: nil) }

        it 'is invalid' do
          expect(result).to be_invalid
        end
      end

      context 'when web_score is blank' do
        let(:result) { build(:result, web_score: nil) }

        it 'is invalid' do
          expect(result).to be_invalid
        end
      end
    end

    describe 'range validation' do
      describe 'ai_score validation' do
        context 'when ai_score is -1' do
          let(:result) { build(:result, ai_score: -1) }

          it 'is invalid' do
            expect(result).to be_invalid
          end
        end

        context 'when ai_score is 0' do
          let(:result) { build(:result, ai_score: 0) }

          it 'is valid' do
            expect(result).to be_valid
          end
        end

        context 'when ai_score is 15' do
          let(:result) { build(:result, ai_score: 15) }

          it 'is valid' do
            expect(result).to be_valid
          end
        end

        context 'when ai_score is 16' do
          let(:result) { build(:result, ai_score: 16) }

          it 'is invalid' do
            expect(result).to be_invalid
          end
        end
      end

      describe 'algorithm_score validation' do
        context 'when algorithm_score is -1' do
          let(:result) { build(:result, algorithm_score: -1) }

          it 'is invalid' do
            expect(result).to be_invalid
          end
        end

        context 'when algorithm_score is 0' do
          let(:result) { build(:result, algorithm_score: 0) }

          it 'is valid' do
            expect(result).to be_valid
          end
        end

        context 'when algorithm_score is 15' do
          let(:result) { build(:result, algorithm_score: 15) }

          it 'is valid' do
            expect(result).to be_valid
          end
        end

        context 'when algorithm_score is 16' do
          let(:result) { build(:result, algorithm_score: 16) }

          it 'is invalid' do
            expect(result).to be_invalid
          end
        end
      end

      describe 'db_score validation' do
        context 'when db_score is -1' do
          let(:result) { build(:result, db_score: -1) }

          it 'is invalid' do
            expect(result).to be_invalid
          end
        end

        context 'when db_score is 0' do
          let(:result) { build(:result, db_score: 0) }

          it 'is valid' do
            expect(result).to be_valid
          end
        end

        context 'when db_score is 15' do
          let(:result) { build(:result, db_score: 15) }

          it 'is valid' do
            expect(result).to be_valid
          end
        end

        context 'when db_score is 16' do
          let(:result) { build(:result, db_score: 16) }

          it 'is invalid' do
            expect(result).to be_invalid
          end
        end
      end

      describe 'web_score validation' do
        context 'when web_score is -1' do
          let(:result) { build(:result, web_score: -1) }

          it 'is invalid' do
            expect(result).to be_invalid
          end
        end

        context 'when web_score is 0' do
          let(:result) { build(:result, web_score: 0) }

          it 'is valid' do
            expect(result).to be_valid
          end
        end

        context 'when web_score is 15' do
          let(:result) { build(:result, web_score: 15) }

          it 'is valid' do
            expect(result).to be_valid
          end
        end

        context 'when web_score is 16' do
          let(:result) { build(:result, web_score: 16) }

          it 'is invalid' do
            expect(result).to be_invalid
          end
        end
      end

      describe 'dependency_score validation' do
        context 'when dependency_score is -1' do
          let(:result) { build(:result, dependency_score: -1) }

          it 'is invalid' do
            expect(result).to be_invalid
          end
        end

        context 'when dependency_score is 0' do
          let(:result) { build(:result, dependency_score: 0) }

          it 'is valid' do
            expect(result).to be_valid
          end
        end

        context 'when dependency_score is 100' do
          let(:result) { build(:result, dependency_score: 100) }

          it 'is valid' do
            expect(result).to be_valid
          end
        end

        context 'when dependency_score is 101' do
          let(:result) { build(:result, dependency_score: 101) }

          it 'is invalid' do
            expect(result).to be_invalid
          end
        end
      end
    end

    describe 'association validation' do
      context 'when user is missing' do
        let(:result) { build(:result, user: nil) }
        it 'is invalid' do
          expect(result).to be_invalid
        end
      end
    end
  end
end
