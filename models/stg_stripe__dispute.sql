
with base as (

    select * 
    from {{ ref('stg_stripe__dispute_tmp') }}

),

fields as (

    select
        /*
        The below macro is used to generate the correct SQL for package staging models. It takes a list of columns 
        that are expected/needed (staging_columns from dbt_stripe_source/models/tmp/) and compares it with columns 
        in the source (source_columns from dbt_stripe_source/macros/).
        For more information refer to our dbt_fivetran_utils documentation (https://github.com/fivetran/dbt_fivetran_utils.git).
        */
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_stripe__dispute_tmp')),
                staging_columns=get_dispute_columns()
            )
        }}
        
    from base
),

final as (
    
    select 
        id as dispute_id,
        amount,
        amount_capturable,
        amount_received,
        application,
        application_fee_amount,
        canceled_at,
        cancellation_reason,
        capture_method,
        confirmation_method,
        created as created_at,
        currency,
        customer_id,
        description,
        last_payment_error_charge_id,
        last_payment_error_code,
        last_payment_error_decline_code,
        last_payment_error_doc_url,
        last_payment_error_message,
        last_payment_error_param,
        last_payment_error_source_id,
        last_payment_error_type,
        livemode,
        metadata,
        on_behalf_of,
        payment_method_id,
        payment_method_types,
        receipt_email,
        source_id,
        statement_descriptor,
        status,
        transfer_data_destination,
        transfer_group
    from fields
)

select * 
from final
