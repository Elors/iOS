from django.conf.urls import include, url
from rest_framework import routers
from rest_framework.authtoken import views as authviews

from . import views

# Routers provide an easy way of automatically determining the URL conf.
router = routers.DefaultRouter()
router.register(r'users', views.UserViewSet)
router.register(r'regions', views.RegionViewSet)
router.register(r'schools', views.SchoolViewSet)
router.register(r'grades', views.GradeViewSet)
router.register(r'subjects', views.SubjectViewSet)
router.register(r'tags', views.TagViewSet)
router.register(r'levels', views.LevelViewSet)
router.register(r'roles', views.RoleViewSet)
router.register(r'profiles', views.ProfileViewSet)
router.register(r'teachers', views.TeacherViewSet)
router.register(r'memberservices', views.MemberserviceViewSet)
router.register(r'weeklytimeslots', views.WeeklyTimeSlotViewSet)

urlpatterns = [
    url(r'^$', views.index, name='index'),
    url(r'^send/sms/checkcode/$', views.sendSmsCheckcode, name='sendSmsCheckcode'),
    url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework')),
    url(r'^api/v1/token-auth/', authviews.obtain_auth_token),
    url(r'^api/v1/', include(router.urls)),
]
