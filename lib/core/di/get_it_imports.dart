import 'package:get_it/get_it.dart';
import 'package:metaltrade/features/auth/data/repo/login_repo_impl.dart';
import 'package:metaltrade/features/auth/domain/repo/login_repo.dart';
import 'package:metaltrade/features/auth/domain/repo/validate_otp_repo.dart';
import 'package:metaltrade/features/auth/domain/usecases/login_usecase.dart';
import 'package:metaltrade/features/auth/domain/usecases/validate_otp_usecase.dart';
import 'package:metaltrade/features/auth/ui/controllers/login_bloc/login_bloc.dart';
import 'package:metaltrade/features/auth/ui/controllers/validate_otp/validate_otp_bloc.dart';
import 'package:metaltrade/features/chat/data/repo/chat_home_list_repo_impl.dart';
import 'package:metaltrade/features/chat/data/repo/chat_list_repo_impl.dart';
import 'package:metaltrade/features/chat/domain/repo/chat_home_list_repo.dart';
import 'package:metaltrade/features/chat/domain/repo/chat_list_repo.dart';
import 'package:metaltrade/features/chat/domain/usecases/chat_home_list_usecase.dart';
import 'package:metaltrade/features/chat/domain/usecases/chat_list_usecase.dart';
import 'package:metaltrade/features/chat/ui/controllers/chat_bloc/chat_bloc.dart';
import 'package:metaltrade/features/chat/ui/controllers/chat_home/chat_home_bloc.dart';
import 'package:metaltrade/features/landing/data/repo/request_callback_repo_impl.dart';
import 'package:metaltrade/features/landing/domain/repo/request_callback_repo.dart';
import 'package:metaltrade/features/landing/domain/usecases/request_callback_usecase.dart';
import 'package:metaltrade/features/landing/ui/controllers/cubit/request_callback_cubit.dart';
import 'package:metaltrade/features/my_home/ui/controllers/my_quote_bloc/my_quote_bloc.dart';
import 'package:metaltrade/features/my_home/ui/controllers/my_rfq_bloc/my_rfq_bloc.dart';
import 'package:metaltrade/features/news/data/repo/news_repo_impl.dart';
import 'package:metaltrade/features/news/domain/repo/news_repo.dart';
import 'package:metaltrade/features/news/domain/usecases/news_usecase.dart';
import 'package:metaltrade/features/news/ui/controllers/news_bloc/news_bloc.dart';
import 'package:metaltrade/features/profile/data/repo/country_repo_impl.dart';
import 'package:metaltrade/features/profile/data/repo/kyc_repo_impl.dart';
import 'package:metaltrade/features/profile/data/repo/my_order_repo_impl.dart';
import 'package:metaltrade/features/profile/domain/repo/country_repo.dart';
import 'package:metaltrade/features/profile/domain/repo/get_profile_repo.dart';
import 'package:metaltrade/features/profile/domain/repo/my_order_repo.dart';
import 'package:metaltrade/features/profile/domain/usecases/country_usecase.dart';
import 'package:metaltrade/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:metaltrade/features/profile/domain/usecases/kyc_usecase.dart';
import 'package:metaltrade/features/profile/domain/usecases/my_order_usecase.dart';
import 'package:metaltrade/features/profile/ui/controllers/country_cubit/country_cubit.dart';
import 'package:metaltrade/features/profile/ui/controllers/kyc_bloc/kyc_bloc.dart';
import 'package:metaltrade/features/profile/ui/controllers/my_order_bloc/my_order_bloc.dart';
import 'package:metaltrade/features/profile/ui/controllers/profile_bloc/profile_bloc.dart';
import 'package:metaltrade/features/quotes/domain/usecases/accept_quote_res_usecase.dart';
import 'package:metaltrade/features/quotes/ui/controllers/accept_quote_bloc/accept_quote_bloc.dart';
import 'package:metaltrade/features/rfq/data/repo/quote_detail_list_repo_impl.dart';
import 'package:metaltrade/features/rfq/data/repo/rfq_enquiry_repo_impl.dart';
import 'package:metaltrade/features/my_home/data/repo/submit_quote_repo_impl.dart';
import 'package:metaltrade/features/my_home/domain/repo/quote_detail_list_repo.dart';
import 'package:metaltrade/features/rfq/domain/repo/rfq_enquiry_repo.dart';
import 'package:metaltrade/features/rfq/domain/repo/submit_quote_repo.dart';
import 'package:metaltrade/features/my_home/domain/usecases/quote_detail_list_usecase.dart';
import 'package:metaltrade/features/rfq/domain/usecases/rfq_usecase.dart';
import 'package:metaltrade/features/rfq/domain/usecases/submit_quote_usecase.dart';
import 'package:metaltrade/features/rfq/ui/controllers/rfq_buyer_enquiry_bloc/rfq_buyer_enquiry_bloc.dart';
import 'package:metaltrade/features/rfq/ui/controllers/rfq_seller_enquiry_bloc/rfq_seller_enquiry_bloc.dart';
import 'package:metaltrade/features/rfq/ui/controllers/submit_quote/submit_quote_bloc.dart';
import '../../features/auth/data/repo/validate_otp_repo_impl.dart';
import '../../features/my_home/data/repo/post_enquiry_repo_impl.dart';
import '../../features/my_home/data/repo/sku_repo_impl.dart';
import '../../features/my_home/domain/repo/post_enquiry_repo.dart';
import '../../features/my_home/domain/repo/sku_repo.dart';
import '../../features/my_home/domain/usecases/post_enquiry_usecase.dart';
import '../../features/my_home/domain/usecases/sku_usecase.dart';
import '../../features/my_home/ui/controllers/create_enquiry_bloc/create_enquiry_bloc.dart';
import '../../features/my_home/ui/controllers/get_sku/get_sku_bloc.dart';
import '../../features/my_home/ui/controllers/quote_detail_list_bloc/quote_detail_list_bloc.dart';
import '../../features/profile/data/repo/profile_repo_impl.dart';
import '../../features/profile/domain/repo/kyc_repo.dart';
import '../../features/rfq/ui/controllers/search_controller/search_bloc.dart';
import '../resource/network/network_manager.dart';

part 'get_it_setup.dart';
