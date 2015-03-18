module Pemilu
  class APIv1 < Grape::API
    version 'v1', using: :accept_version_header
    prefix 'api'
    format :json

    resource :ambang_batas do
      desc "Return all provinces"
      get do
        ambang_batas = Array.new

       # Prepare conditions based on params
        valid_params = {
          partai: 'party_id',
          status: 'status'
        }

        conditions = Hash.new
        valid_params.each_pair do |key, value|
          conditions[value.to_sym] = params[key.to_sym] unless params[key.to_sym].blank?
        end

        # Set default limit
        limit = (params[:limit].to_i == 0 || params[:limit].empty?) ? 12 : params[:limit]

        Treshold.includes(:party)
          .where(conditions)
          .limit(limit)
          .offset(params[:offset])
          .each do |treshold|
            ambang_batas << {
              id: treshold.id,
              partai: {
                id: treshold.party_id,
                nama: treshold.party_nama_lengkap,
              },
              perolehan_suara: treshold.total,
              presentase: treshold.precentage,
              status: treshold.status
            }
          end

        {
          results: {
            count: ambang_batas.count,
            total: Treshold.where(conditions).count,
            dapil: ambang_batas
          }
        }
      end
    end
  end
end