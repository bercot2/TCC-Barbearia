class RepresentationMixin:
    def to_representation(self, instance):
        data = super().to_representation(instance)

        if hasattr(self, "representations"):
            for attr, representation in self.representations.items():

                if attr not in self.fields:
                    continue

                serializer = representation.get('serializer', None)
                many = representation.get('many', False)
                fields = representation.get('fields', None)

                if hasattr(self, "context"):
                    request = self.context.get('request', None)

                    if request:
                        requested_fields = request.query_params.get(
                            f'{attr}_fields', None)

                        if requested_fields:
                            fields = [field.strip()
                                    for field in requested_fields.split(',')]

                if hasattr(instance, attr):
                    attr_value = getattr(instance, attr)

                    if not serializer:
                        data[attr] = 'Serializer not set.'
                    if serializer and attr_value:
                        serializer_instance = serializer(attr_value, many=many)

                        if fields:
                            serializer_instance.fields = {
                                key: value for key, value in serializer_instance.fields.items() if key in fields
                            }

                        data[attr] = serializer_instance.data
                    else:
                        data[attr] = [] if many else None

        return data
